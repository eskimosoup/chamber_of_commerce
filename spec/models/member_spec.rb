# == Schema Information
#
# Table name: members
#
#  id                  :integer          not null, primary key
#  address             :text
#  company_name        :string
#  email               :string
#  fax                 :string
#  in_csv              :boolean          default(TRUE)
#  member_offers_count :integer          default(0)
#  nature_of_business  :text
#  post_code           :string
#  slug                :string
#  telephone           :string
#  verified            :boolean
#  website             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  chamber_db_id       :integer
#  member_login_id     :integer
#
# Indexes
#
#  index_members_on_chamber_db_id    (chamber_db_id)
#  index_members_on_member_login_id  (member_login_id)
#
require "rails_helper"

RSpec.describe Member, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:company_name) }
    #it { should validate_presence_of(:address) }
    #it { should validate_presence_of(:telephone) }
    #it { should validate_presence_of(:nature_of_business) }
  end

  describe "associations", :association do
    it { should have_one(:member_login) }
    it { should have_many(:member_offers) }
    it { should have_many(:member_industries).dependent(:destroy) }
    it { should have_many(:industries).through(:member_industries) }
  end
end
