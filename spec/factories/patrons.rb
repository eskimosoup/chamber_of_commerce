# == Schema Information
#
# Table name: patrons
#
#  id         :integer          not null, primary key
#  display    :boolean          default(TRUE)
#  highlight  :boolean          default(FALSE)
#  image      :string           not null
#  link       :string
#  name       :string           not null
#  no_follow  :boolean          default(FALSE)
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :patron do
    name "Name"
  end
end
