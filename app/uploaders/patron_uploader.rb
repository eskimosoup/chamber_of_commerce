class PatronUploader < Optimadmin::ImageUploader

  version :show do
    process :resize_to_fill => [118, 60]
  end

end
