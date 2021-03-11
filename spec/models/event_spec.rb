# == Schema Information
#
# Table name: events
#
#  id                               :integer          not null, primary key
#  allow_booking                    :boolean          default(TRUE)
#  booking_confirmation_information :text
#  booking_deadline                 :datetime
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
require "rails_helper"

RSpec.describe Event, type: :model do
  subject(:event) { build(:event) }
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:event_location_id) }
    it { should validate_presence_of(:event_office_id) }
    it { should validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically')}
    it "should validate sensible dates"
  end

  describe "associations", :association do

  end
end
