# == Schema Information
#
# Table name: patrons
#
#  id         :integer          not null, primary key
#  display    :boolean          default(TRUE)
#  image      :string           not null
#  link       :string
#  name       :string           not null
#  no_follow  :boolean          default(FALSE)
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Patron < ActiveRecord::Base
  mount_uploader :image, PatronUploader

  validates :name, :image, presence: true

  scope :display, -> { where(display: true).order(position: :asc) }
end
