class Upload < Entry
  mount_uploader :attachment, DocumentUploader
end
