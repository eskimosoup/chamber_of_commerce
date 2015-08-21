require 'rails_helper'

RSpec.describe Industry, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
  end

  describe "associations", :association do
    it { should have_many(:member_industries).dependent(:destroy) }
    it { should have_many(:members).through(:member_industries) }
  end
end
