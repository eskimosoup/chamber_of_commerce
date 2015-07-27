class Patron < ActiveRecord::Base
  mount_uploader :image, PatronUploader

  validates :name, :image, presence: true

  scope :display, -> { where(display: true).order(position: :asc) }
end
