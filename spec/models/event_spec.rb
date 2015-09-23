require "rails_helper"

RSpec.describe Event, type: :model do
  subject(:event) { build(:event) }
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:event_location_id) }
    it { should validate_presence_of(:event_office_id) }
    it { should validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically')}
    it "should validate sensible dates"
  end

  describe "associations", :association do

  end
end