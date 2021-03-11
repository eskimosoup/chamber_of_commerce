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
require 'rails_helper'

RSpec.describe EventLocation, type: :model do

end
