# == Schema Information
#
# Table name: event_agendas
#
#  id                :integer          not null, primary key
#  description       :text
#  end_time          :time
#  maximum_capacity  :integer
#  must_book         :boolean
#  name              :string           not null
#  price             :decimal(8, 2)    default(0.0)
#  start_time        :time
#  table_discount    :decimal(5, 2)    default(0.0)
#  table_size        :integer          default(10)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  event_category_id :integer
#  event_id          :integer
#
# Indexes
#
#  index_event_agendas_on_event_category_id  (event_category_id)
#  index_event_agendas_on_event_id           (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_category_id => event_categories.id)
#  fk_rails_...  (event_id => events.id)
#
require 'rails_helper'

RSpec.describe EventAgenda, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:event_category) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:table_size).only_integer }
    it { should validate_numericality_of(:table_discount).allow_nil }
  end

  describe "associations", :association do
    it { should belong_to(:event) }
    it { should belong_to(:event_category) }
    it { should have_many(:attendee_event_agendas).dependent(:nullify) }
    it { should have_many(:attendees).through(:attendee_event_agendas) }
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
