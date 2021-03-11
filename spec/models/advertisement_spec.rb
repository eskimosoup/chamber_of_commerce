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
require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
