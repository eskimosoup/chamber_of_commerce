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
FactoryGirl.define do
  factory :member do
    email "paul@optimised.today"
    sequence(:company_name) { |n| "Company #{n}" }
    address "address"
    telephone "telephone"
    website "website"
    nature_of_business "nature of business"
  end
end
