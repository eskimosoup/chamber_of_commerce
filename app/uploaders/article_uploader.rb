class ArticleUploader < Optimadmin::ImageUploader

  version :index do
    process :resize_to_fill => [250, 250]
  end

  version :show do
    process :resize_to_fill => [800, 400]
  end

end