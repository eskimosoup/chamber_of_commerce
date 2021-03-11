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
FactoryGirl.define do
  factory :advertisement do
    name "MyString"
    url "MyString"
    image_large "MyString"
    image_medium "MyString"
    image_small "MyString"
    publish_at "2018-06-19 10:16:37"
    expire_at "2018-06-19 10:16:37"
  end
end
