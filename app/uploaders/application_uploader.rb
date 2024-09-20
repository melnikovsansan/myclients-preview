class ApplicationUploader < CarrierWave::Uploader::Base
  def initialize(*)
    super

    self.fog_directory = RequestStore[:bucket]
  end
end
