class PreviewUploader < ApplicationUploader
  def store_dir
    nil
  end

  version :thumbnail, if: UnoThumbnail.method(:version_enabled?) do
    include UnoThumbnail::Process
  end

  version :pdf_preview, if: UnoPdfPreview.method(:version_enabled?) do
    include UnoPdfPreview::Process
  end
end
