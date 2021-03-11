# == Schema Information
#
# Table name: memberships_how_heards
#
#  id         :integer          not null, primary key
#  display    :boolean          default(TRUE)
#  position   :integer          default(0)
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :memberships_how_heard, class: 'Memberships::HowHeard' do
    position 1
    title "MyString"
    display false
  end
end
