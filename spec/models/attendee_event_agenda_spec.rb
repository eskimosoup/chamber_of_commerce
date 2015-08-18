require 'rails_helper'

RSpec.describe AttendeeEventAgenda, type: :model do
  describe "associations", :association do
    it { should belong_to(:attendee) }
    it { should belong_to(:event_agenda) }
  end
end
