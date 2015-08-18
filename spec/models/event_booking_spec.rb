require 'rails_helper'

RSpec.describe EventBooking, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }
  end

  describe "associations", :association do
    it { should belong_to(:event) }
    it { should have_many(:attendees).dependent(:destroy) }
    it { should accept_nested_attributes_for(:attendees) }
  end

  describe "event booking price" do
    subject(:event_booking) { build(:event_booking) }

    it "should sum the price correctly" do
      cost_array = [BigDecimal.new("5.25"), BigDecimal.new("10.75"), BigDecimal.new("5.50")]
      allow(event_booking).to receive(:attendee_prices) { cost_array }
      expect(event_booking.price).to eq(cost_array.reduce(:+))
    end

    it "should return a stripe price in pence" do
      cost_array = [BigDecimal.new("5.25"), BigDecimal.new("10.75"), BigDecimal.new("5.50")]
      allow(event_booking).to receive(:attendee_prices) { cost_array }
      expect(event_booking.stripe_price).to eq(cost_array.reduce(:+) * 100)
    end
  end
end
