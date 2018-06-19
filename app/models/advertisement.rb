class Advertisement < ActiveRecord::Base
  include OptimadminScopes
  include DisplayStatus

  mount_uploader :image_small, Optimadmin::DocumentUploader
  mount_uploader :image_medium, Optimadmin::DocumentUploader
  mount_uploader :image_large, Optimadmin::DocumentUploader

  validates :name, presence: true
  validates :url, presence: true
  validates :image_small, presence: true
  validates :image_medium, presence: true
  validates :image_large, presence: true

  scope :displayed, -> { published }
end
