# == Schema Information
#
# Table name: events
#
#  id                               :integer          not null, primary key
#  allow_booking                    :boolean          default(TRUE)
#  booking_confirmation_information :text
#  booking_deadline                 :datetime
#  booking_start_date               :datetime
#  caption                          :string
#  description                      :text
#  display                          :boolean          default(TRUE)
#  end_date                         :date
#  event_agendas_count              :integer          default(0)
#  event_bookings_count             :integer          default(0)
#  eventbrite_link                  :string
#  fully_booked_content             :text
#  image                            :string
#  layout                           :string
#  name                             :string           not null
#  slug                             :string
#  start_date                       :date
#  suggested_url                    :string
#  summary                          :text
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  event_agendas_id                 :integer
#  event_location_id                :integer
#  event_office_id                  :integer
#
# Indexes
#
#  index_events_on_event_agendas_id   (event_agendas_id)
#  index_events_on_event_location_id  (event_location_id)
#  index_events_on_event_office_id    (event_office_id)
#
FactoryGirl.define do
  factory :event do
    sequence(:name) {|n| "Event #{ n }" }
    event_location
    event_office
    start_date { Date.today + 1.day }
    end_date { Date.today + 1.day }
    summary "My event summary"
    description "My event description"
    eventbrite_link nil
    display true
    allow_booking true
  end
end
