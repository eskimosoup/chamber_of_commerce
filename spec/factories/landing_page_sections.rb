# == Schema Information
#
# Table name: landing_page_sections
#
#  id              :integer          not null, primary key
#  area            :string           not null
#  button_link     :string
#  button_text     :string
#  content         :text
#  display         :boolean          default(TRUE)
#  image           :string
#  position        :integer          default(0)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  landing_page_id :integer
#
# Indexes
#
#  index_landing_page_sections_on_area             (area)
#  index_landing_page_sections_on_landing_page_id  (landing_page_id)
#
# Foreign Keys
#
#  fk_rails_...  (landing_page_id => landing_pages.id)
#
FactoryGirl.define do
  factory :landing_page_section do
    landing_page nil
    position 1
    area "MyString"
    title "MyString"
    content "MyText"
    image "MyString"
    button_link "MyString"
    button_text "MyString"
    display false
  end
end
