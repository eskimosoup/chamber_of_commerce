# == Schema Information
#
# Table name: industries
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  chamber_db_id :integer
#
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
