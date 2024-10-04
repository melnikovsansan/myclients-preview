class PreviewService
  attr_reader :options

  delegate :add_column, :create_table, to: :'ActiveRecord::Migration'
  delegate :model_name, to: :model

  def self.call(**options)
    new(**options).perform
  end

  def initialize(**options)
    @options = options
  end

  def perform
    Thread.new { process }.tap { |thread| thread.join if Rails.env.test? }
  end

  private

  def process
    RequestStore[:bucket] = options[:bucket]
    uploader.recreate_versions!
    log
    perform_callback(versions: uploader.versions)
  end

  def perform_callback(**response_params)
    HTTParty.post(
      callback,
      body: options.slice(:model_name, :id, :attribute_name).merge(response_params).to_json,
      headers: {'Content-Type': 'application/json'}
    )
  end

  def log
    uploader.versions.each do |_, uploader|
      RAILS::Logger.log uploader.url
    end
  end

  def model_name
    @_model_name ||= options[:model_name]
  end

  def model
    @_model ||= model_name.safe_constantize || Object.const_set(model_name, Class.new(ApplicationRecord))
  end

  def uploader
    @_uploader ||=
      begin
        handle_database
        id, attribute_name, file_name = options[:id], options[:attribute_name], options[:file_name]
        model.class_eval do
          mount_uploader attribute_name, PreviewUploader

          instance = find_or_create_by(id: id)
          instance.update_columns(attribute_name => file_name)
          instance.public_send(attribute_name)
        end
      end
  end

  def handle_database
    return if model.column_names.include?(options[:attribute_name])

    ActiveRecord::Migration.add_column model.model_name.collection, options[:attribute_name], :string, if_not_exists: true
    model.reset_column_information
  rescue ActiveRecord::StatementInvalid
    ActiveRecord::Migration.create_table model.model_name.collection, id: :uuid, if_not_exists: true do |t|
      t.timestamps
    end
    model.connection.reconnect!
    retry
  end
end
