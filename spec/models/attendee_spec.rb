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
require 'rails_helper'

RSpec.describe Attendee, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:attendee_event_agendas) }
    it { should validate_presence_of(:forename) }
    it { should validate_presence_of(:surname) }
  end

  describe "associations", :association do
    it { should belong_to(:event_booking).counter_cache }
    it { should have_many(:attendee_event_agendas).dependent(:destroy) }
    it { should have_many(:event_agendas).through(:attendee_event_agendas) }
  end

  describe "agendas visiting price" do
    subject(:attendee) { create(:attendee) }

    it "should sum the price correctly" do
      total = attendee.event_agendas.map(&:price).reduce(:+)
      expect(attendee.agendas_total_price).to eq(total)
    end
  end

  describe "agenda_ids method" do
    subject(:attendee) { create(:attendee) }
    it "should return the agenda ids" do
      agenda_ids = attendee.attendee_event_agendas.map(&:event_agenda_id)
      expect(attendee.agenda_ids).to eq(agenda_ids)
    end
  end
end
