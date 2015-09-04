require 'rails_helper'

RSpec.describe EventAgenda, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:event_category) }
    it { should validate_presence_of(:table_size) }
    it { should validate_numericality_of(:table_size).only_integer }
    it { should validate_numericality_of(:table_discount).allow_nil }
  end

  describe "associations", :association do
    it { should belong_to(:event) }
    it { should belong_to(:event_category) }
    it { should have_many(:attendee_event_agendas).dependent(:nullify) }
  end

  describe "calculating open spaces" do
    subject(:event_agenda) { build(:event_agenda) }
    it "should return 0 if full" do
      allow(event_agenda).to receive(:attendee_event_agendas_count) { event_agenda.maximum_capacity }
      expect(event_agenda.open_spaces).to eq(0)
    end

    it "should return the open spaces if not full" do
      allow(event_agenda).to receive(:attendee_event_agendas_count) { event_agenda.maximum_capacity - 2 }
      expect(event_agenda.open_spaces).to eq(2)
    end

    it "should know it is full" do
      allow(event_agenda).to receive(:attendee_event_agendas_count) { event_agenda.maximum_capacity - 2 }
      expect(event_agenda.full?(3)).to be true
    end

    it "should know it is not full" do
      allow(event_agenda).to receive(:attendee_event_agendas_count) { event_agenda.maximum_capacity - 2 }
      expect(event_agenda.full?(2)).to be false
    end
  end

end