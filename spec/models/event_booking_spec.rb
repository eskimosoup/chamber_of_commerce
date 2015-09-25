require 'rails_helper'

RSpec.describe EventBooking, type: :model do
  describe "validations" do
    it { should validate_presence_of(:forename) }
    it { should validate_presence_of(:surname) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:stripe_charge_id).on(:update) }
  end

  describe "associations", :association do
    it { should belong_to(:event) }
    it { should have_many(:attendees).dependent(:destroy) }
    it { should accept_nested_attributes_for(:attendees) }
  end

  describe "checking agendas attended by attendees" do
    subject(:event_booking) { build(:event_booking) }
    before(:each) do
      attendees = [instance_double(Attendee, agenda_ids: [1, 2, 3]),
                   instance_double(Attendee, agenda_ids: [1, 2, 3, 4]), instance_double(Attendee, agenda_ids: [2])]
      allow(event_booking).to receive(:attendees) { attendees }
    end

    it "should correctly map the event agenda ids" do
      expect(event_booking.attendee_event_agenda_ids).to eq([1,2,3,1,2,3,4,2])
    end

    it "should return a hash of the agenda id and the number of attendees attending" do
      expect(event_booking.agenda_id_frequency).to eq({ 1 => 2, 2 => 3, 3 => 2, 4 => 1})
    end
  end


end
