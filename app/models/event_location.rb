# == Schema Information
#
# Table name: event_locations
#
#  id             :integer          not null, primary key
#  address_line_1 :string           not null
#  address_line_2 :string
#  city           :string           not null
#  latitude       :float
#  location_name  :string
#  longitude      :float
#  post_code      :string
#  region         :string
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class EventLocation < ActiveRecord::Base
  extend FriendlyId
  friendly_id :location_name, use: [:slugged, :history]

  has_many :events

  validates :location_name, :address_line_1, :city, presence: true
  geocoded_by :address

  after_validation :geocode, if: ->(obj){ (obj.address_line_1.present? && obj.address_line_1_changed?) || !latitude? || !longitude? }


  def address
    [address_line_1, address_line_2, city, region, post_code].compact.reject{|x| x.empty? if x.class == String}.join(', ')
  end
end
