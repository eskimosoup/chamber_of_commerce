# == Schema Information
#
# Table name: memberships_join_reasons
#
#  id         :integer          not null, primary key
#  display    :boolean          default(TRUE)
#  position   :integer          default(0)
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :memberships_join_reason, class: 'Memberships::JoinReason' do
    position 1
    title "MyString"
    display false
  end
end
