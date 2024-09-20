class Some
  include ActiveModel::Model
  extend CarrierWave::Mount

  mount_uploader :attachment, DocumentUploader
end
