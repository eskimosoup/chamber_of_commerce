# == Schema Information
#
# Table name: event_bookings
#
#  id                       :integer          not null, primary key
#  address_line_1           :string
#  address_line_2           :string
#  attendees_count          :integer          default(0)
#  booked_on_full_event     :boolean          default(FALSE)
#  company_name             :string
#  email                    :string
#  forename                 :string           not null
#  industry                 :string
#  nature_of_business       :string
#  paid                     :boolean          default(FALSE)
#  payment_method           :string
#  phone_number             :string
#  postcode                 :string
#  refunded                 :boolean          default(FALSE)
#  surname                  :string
#  town                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  event_id                 :integer
#  stripe_charge_id         :string
#  stripe_payment_intent_id :string
#
# Indexes
#
#  index_event_bookings_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
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
