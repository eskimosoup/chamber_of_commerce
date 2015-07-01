class MagazineUploader < Optimadmin::ImageUploader

  version :show do
    process :resize_to_fill => [162, 183]
  end

end
