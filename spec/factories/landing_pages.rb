# == Schema Information
#
# Table name: landing_pages
#
#  id            :integer          not null, primary key
#  content       :text
#  display       :boolean          default(TRUE)
#  footer        :text
#  header        :text
#  image         :string
#  layout        :string           default("application")
#  slug          :string
#  style         :string           default("basic")
#  suggested_url :string
#  title         :string           not null
#  video_embed   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_landing_pages_on_slug  (slug)
#
FactoryGirl.define do
  factory :landing_page do
    title "MyString"
    header "MyText"
    content "MyText"
    footer "MyText"
    display false
    style "MyString"
    layout "MyString"
    suggested_url "MyString"
  end
end
