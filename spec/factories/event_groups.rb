# == Schema Information
#
# Table name: event_groups
#
#  id            :integer          not null, primary key
#  area          :string
#  content       :text
#  display       :boolean          default(TRUE)
#  position      :integer          default(0)
#  slug          :string
#  suggested_url :string
#  summary       :text
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_event_groups_on_slug  (slug)
#
FactoryGirl.define do
  factory :event_group do
    position 1
    title "MyString"
    display false
  end
end
