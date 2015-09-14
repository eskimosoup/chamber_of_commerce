class MagazineUploader < Optimadmin::ImageUploader

  version :show do
    process resize_to_limit: [162, 216]
  end

end
