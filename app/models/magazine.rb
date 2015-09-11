class Magazine < ActiveRecord::Base
  mount_uploader :image, MagazineUploader
  mount_uploader :file, Optimadmin::DocumentUploader

  validates :name, :file, :date, :image, presence: true
end
