class ArticleUploader < Optimadmin::ImageUploader

  version :index do
    process resize_to_fill: [223, 223]
  end

  version :show do
    process resize_to_fill: [215, 135]
  end

  version :homepage do
    process resize_to_fill: [450, 295]
  end

end
