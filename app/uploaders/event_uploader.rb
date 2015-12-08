class EventUploader < Optimadmin::ImageUploader

  version :homepage do
    process resize_to_fill: [418, 280]
  end

  version :index do
    process resize_to_fill: [223, 223]
  end

  version :show do
    process resize_to_fit: [218, 9999]
  end

  version :show_full_image do
    process resize_to_fit: [613, 9999]
  end
end
