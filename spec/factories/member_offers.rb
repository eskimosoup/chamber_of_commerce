# == Schema Information
#
# Table name: member_offers
#
#  id           :integer          not null, primary key
#  description  :text
#  end_date     :date
#  image        :string
#  slug         :string
#  start_date   :date
#  summary      :text             not null
#  title        :string           not null
#  verified     :boolean
#  website_link :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  member_id    :integer
#
# Indexes
#
#  index_member_offers_on_member_id  (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => members.id)
#
FactoryGirl.define do
  factory :member_offer do
    member nil
    title "MyString"
    summary "MyText"
    description "MyText"
    website_link "MyString"
    image "MyString"
    start_date "2015-08-03"
    end_date "2015-08-03"
    verified false
  end

end
