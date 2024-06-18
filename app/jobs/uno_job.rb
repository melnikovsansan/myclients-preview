class UnoJob < ApplicationJob
  queue_as :uno

  attr_reader :record_class, :record_id, :mounted_as

  def perform(record_class, record_id, mounted_as)
    @record_class = record_class
    @record_id = record_id
    @mounted_as = mounted_as

    record.company.current!
    uploader.recreate_versions!
    update_record!
  end

  private

  def record
    @_record ||= record_class.constantize.find(record_id)
  end

  def uploader
    @_uploader ||= record.public_send(mounted_as)
  end
  
  def update_record!
    uploader.versions.each do |version_name, uploader|
      version_mounted_as = "#{mounted_as}_#{version_name}"
      record[version_mounted_as] = uploader.file.filename if record.respond_to?(version_mounted_as)
    end
    record.save!
  end
end
