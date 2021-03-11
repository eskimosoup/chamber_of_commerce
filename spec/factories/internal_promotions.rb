# == Schema Information
#
# Table name: internal_promotions
#
#  id         :integer          not null, primary key
#  area       :string           not null
#  display    :boolean          default(TRUE)
#  image      :string
#  link       :string
#  name       :string           not null
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :internal_promotion do
    name 'Name'
    area 'Area'
    text 'Text'
  end
end
