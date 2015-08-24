FactoryGirl.define do
  factory :event_agenda do
    sequence(:name) {|n| "Agenda #{ n }" }
    event_category
    event
    start_time { Time.now + 3.hours }
    end_time { Time.now + 5.hours }
    price 9.99

    description "Some text"
    maximum_capacity 5
    table_size 2
    table_discount 5.0
  end
end