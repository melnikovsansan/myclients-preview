class ApplicationUploader < CarrierWave::Uploader::Base
  def initialize(*)
    super

    self.fog_directory = Company.current.bucket
  end
end
