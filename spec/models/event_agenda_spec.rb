require 'rails_helper'

RSpec.describe EventAgenda, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:event_category) }
    it { should validate_presence_of(:description) }
  end

  describe "associations", :association do
    it { should belong_to(:event) }
    it { should belong_to(:event_category) }
    it { should have_many(:attendee_event_agendas).dependent(:nullify) }
  end
end