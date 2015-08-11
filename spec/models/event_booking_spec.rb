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


end
