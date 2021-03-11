# == Schema Information
#
# Table name: event_offices
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :event_office do
    sequence(:name){|n| "Name #{n}" }
    sequence(:email){|n| "test#{ n }@example.com" }
  end

end
