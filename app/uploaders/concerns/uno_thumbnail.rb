module UnoThumbnail
  extend ActiveSupport::Concern
  extend UnoVersions

  EXTENSION_ALLOWLIST = %w(doc docx).freeze

  module Process
    extend ActiveSupport::Concern

    included do
      process generate_thumbnail: []

      def generate_thumbnail
        cache! unless cached?
        output_path = File.join(File.dirname(current_path), filename)
        Unoconvert.call(path, output_path, **filter_options)

        file.content_type = 'image/jpeg'
        file.instance_variable_set(:@file, output_path)
      end

      def filter_options
        {
          pixel_width: 400,
          pixel_height: 517,
          quality: 70,
        }
      end

      def full_filename(for_file)
        "#{version_name}_#{File.basename(for_file, File.extname(for_file))}.jpg"
      end

      def filename
        super.chomp(File.extname(super)) + '.jpg'
      end

      def extension_allowlist
        EXTENSION_ALLOWLIST
      end
    end
  end
end
