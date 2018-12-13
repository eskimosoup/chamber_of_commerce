class ArticleUploader < Optimadmin::ImageUploader

=begin
  version :index do
    process resize_to_fill: [223, 223]
  end

  version :show do
    process resize_to_fill: [215, 135]
  end
=end

  version :show_full_image do
    process resize_to_fit: [613, 9999]
  end

  version :homepage do
    process resize_to_fill: [450, 295]
  end
end
