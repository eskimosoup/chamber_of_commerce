require 'rails_helper'

RSpec.describe Attendee, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:attendee_event_agendas) }
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
end
