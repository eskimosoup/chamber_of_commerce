# == Schema Information
#
# Table name: industries
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  chamber_db_id :integer
#
FactoryGirl.define do
  factory :industry do
    name "MyString"
chamber_db_id 1
  end

end
