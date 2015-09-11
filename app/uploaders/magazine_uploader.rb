class MagazineUploader < Optimadmin::ImageUploader

  version :show do
    process resize_to_limit: [162, 193]
  end

end
