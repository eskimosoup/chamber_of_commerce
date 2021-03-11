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
class MemberIndustry < ActiveRecord::Base
  belongs_to :member
  belongs_to :industry
end
