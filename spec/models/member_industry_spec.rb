# == Schema Information
#
# Table name: member_industries
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  industry_id :integer
#  member_id   :integer
#
# Indexes
#
#  index_member_industries_on_industry_id  (industry_id)
#  index_member_industries_on_member_id    (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (industry_id => industries.id)
#  fk_rails_...  (member_id => members.id)
#
require 'rails_helper'

RSpec.describe MemberIndustry, type: :model do
  describe "associations", :association do
    it { should belong_to(:member) }
    it { should belong_to(:industry) }
  end
end
