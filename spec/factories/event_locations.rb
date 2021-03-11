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
FactoryGirl.define do
  factory :event_location do
    address_line_1 "156 High Street"
    city "Hull"
    region "Yorkshire"
    post_code "HU1 1NQ"
    latitude 53.743316
    longitude -0.331004
    location_name "Work"
  end
end
