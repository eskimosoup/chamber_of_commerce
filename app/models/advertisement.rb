class Advertisement < ActiveRecord::Base
  include OptimadminScopes
  include DisplayStatus

  geocoded_by :postcode
  after_validation :geocode, if: :postcode_changed?

  mount_uploader :image_small, Optimadmin::DocumentUploader
  mount_uploader :image_medium, Optimadmin::DocumentUploader
  mount_uploader :image_large, Optimadmin::DocumentUploader

  validates :name, presence: true
  validates :url, presence: true
  validates :image_small, presence: true
  validates :image_medium, presence: true
  validates :image_large, presence: true
  validates :postcode, presence: true, if: :postcode_radius?
  validates :postcode_radius, presence: true, if: :postcode?


  scope :displayed, -> { published }
end
