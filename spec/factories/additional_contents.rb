# == Schema Information
#
# Table name: additional_contents
#
#  id          :integer          not null, primary key
#  area        :string
#  button_link :string
#  button_text :text
#  content     :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryGirl.define do
  factory :additional_content do
    area 'Area'
    title 'Title'
    content 'Content'
  end
end
