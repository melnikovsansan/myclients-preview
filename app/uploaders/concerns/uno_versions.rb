module UnoVersions
  extend ActiveSupport::Concern

  MODULES = [UnoThumbnail, UnoPdfPreview].freeze

  def version_enabled?(version, _options)
    extension_enabled?(version.file)
  end

  private

  def extension_enabled?(file)
    file.extension.in?(self::EXTENSION_ALLOWLIST)
  end
end
