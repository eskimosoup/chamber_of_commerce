class PageUploader < Optimadmin::ImageUploader

  version :show do
    process :resize_to_fill => [218, 135]
  end

end
