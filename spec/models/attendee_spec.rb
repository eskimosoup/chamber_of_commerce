require 'rails_helper'

RSpec.describe Attendee, type: :model do
  describe "validations", :validation do

  end

  describe "associations", :association do
    it { should belong_to(:event_booking).counter_cache }
  end
end
