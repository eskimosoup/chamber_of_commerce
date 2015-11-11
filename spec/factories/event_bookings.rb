FactoryGirl.define do
  factory :event_booking do
    event
    forename "Forename"
    surname "Surname"
    company_name "MyString"
    industry "MyString"
    nature_of_business "MyString"
    address_line_1 "MyText"
    address_line_2 "MyText"
    town "MyText"
    postcode "MyText"
    phone_number "MyString"
    email "MyString"
    paid false

    before(:create) do |booking, evaluator|
      booking.attendees = evaluator.attendees if evaluator.attendees.present?
    end

    factory :event_booking_with_attendees do
      after(:build) do |event_booking|
        event_booking.attendees = create_list(:attendee, rand(1..3), event_booking: event_booking)
      end
    end
  end

end
