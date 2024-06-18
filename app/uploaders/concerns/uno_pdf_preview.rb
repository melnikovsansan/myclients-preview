module UnoPdfPreview
  extend ActiveSupport::Concern
  extend UnoVersions

  EXTENSION_ALLOWLIST = %w(doc docx).freeze

  module Process
    extend ActiveSupport::Concern

    included do
      process generate_pdf_preview: []

      def generate_pdf_preview
        cache! unless cached?
        output_path = File.join(File.dirname(current_path), filename)
        Unoconvert.call(path, output_path, **filter_options)

        file.content_type = 'application/pdf'
        file.instance_variable_set(:@file, output_path)
      end

      def filter_options
        {
        }
      end

      def full_filename(for_file)
        "#{version_name}_#{File.basename(for_file, File.extname(for_file))}.pdf"
      end

      def filename
        super.chomp(File.extname(super)) + '.pdf'
      end

      def extension_allowlist
        EXTENSION_ALLOWLIST
      end
    end
  end
end
