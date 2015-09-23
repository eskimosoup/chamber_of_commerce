FactoryGirl.define do
  factory :event_office do
    sequence(:name){|n| "Name #{n}" }
    sequence(:email){|n| "test#{ n }@example.com" }
  end

end
