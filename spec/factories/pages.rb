# == Schema Information
#
# Table name: pages
#
#  id            :integer          not null, primary key
#  content       :text
#  display       :boolean          default(TRUE)
#  image         :string
#  layout        :string
#  page_type     :string
#  slug          :string
#  style         :string
#  suggested_url :string
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryGirl.define do
  factory :page do
    sequence(:title) {|n| "My page title #{n}" }
    content "Some content"
  end
end
