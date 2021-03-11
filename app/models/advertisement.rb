# == Schema Information
#
# Table name: advertisements
#
#  id              :integer          not null, primary key
#  expire_at       :datetime
#  image_large     :string           not null
#  image_medium    :string           not null
#  image_small     :string           not null
#  latitude        :float
#  longitude       :float
#  name            :string           not null
#  postcode        :string
#  postcode_radius :decimal(16, 6)
#  publish_at      :datetime         not null
#  url             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
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
