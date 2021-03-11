# == Schema Information
#
# Table name: attendees
#
#  id                   :integer          not null, primary key
#  dietary_requirements :text
#  email                :string
#  forename             :string
#  phone_number         :string
#  surname              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  event_booking_id     :integer
#
# Indexes
#
#  index_attendees_on_event_booking_id  (event_booking_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_booking_id => event_bookings.id)
#
FactoryGirl.define do
  factory :attendee do
    association :event_booking, strategy: :build
    phone_number "MyString"
    forename "Forename"
    surname "Surname"
    sequence(:email) {|n| "example#{ n }@example.com" }
    dietary_requirements "MyText"
    event_agendas { create_list(:event_agenda, rand(1..3)) }
  end

end
