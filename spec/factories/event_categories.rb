# == Schema Information
#
# Table name: event_categories
#
#  id            :integer          not null, primary key
#  bookable      :boolean          default(TRUE)
#  food_event    :boolean
#  has_tables    :boolean
#  name          :string           not null
#  position      :integer
#  slug          :string
#  suggested_url :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  parent_id     :integer
#
FactoryGirl.define do
  factory :event_category do
    sequence(:name) {|n| "Event Category #{ n }" }
  end
end
