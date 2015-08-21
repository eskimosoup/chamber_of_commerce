class MemberIndustry < ActiveRecord::Base
  belongs_to :member
  belongs_to :industry
end
