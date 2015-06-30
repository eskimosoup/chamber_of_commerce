class InternalPromotionUploader < Optimadmin::ImageUploader

  version :homepage do
    process :resize_to_fill => [728, 90]
  end

end
