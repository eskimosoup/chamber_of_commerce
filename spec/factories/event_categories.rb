FactoryGirl.define do
  factory :event_category do
    sequence(:name) {|n| "Event Category #{ n }" }
  end
end