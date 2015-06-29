class Patron < ActiveRecord::Base
  mount_uploader :image, PatronUploader

  validates :name, :image, presence: true
end
