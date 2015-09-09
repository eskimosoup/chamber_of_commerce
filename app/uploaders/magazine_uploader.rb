class MagazineUploader < Optimadmin::ImageUploader

  version :show do
    process resize_to_fill: [162, 193]
  end

end
