FactoryGirl.define do
  factory :event_agenda do
    sequence(:name) {|n| "Agenda #{ n }" }
    event_category
    event
    start_time { Time.now + 3.hours }
    end_time { Time.now + 5.hours }

    description "Some text"
    maximum_capacity 5
  end
end