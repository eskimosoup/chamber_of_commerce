FactoryGirl.define do
  factory :event do
    sequence(:name) {|n| "Event #{ n }" }
    event_location
    start_date { Date.today + 1.day }
    end_date { Date.today + 1.day }
    summary "My event summary"
    description "My event description"
    eventbrite_link nil
    display true
    allow_booking true
  end
end