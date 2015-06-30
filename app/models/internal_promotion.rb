class InternalPromotion < ActiveRecord::Base
  mount_uploader :image, InternalPromotionUploader

  validates :name, :area, :image, presence: true

  AREAS = [
              'Home - Members Area',
              'Home - About the Chamber',
              'Home - We\'re Social'
            ]
end
