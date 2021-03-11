# == Schema Information
#
# Table name: memberships_packages
#
#  id         :integer          not null, primary key
#  cost       :decimal(8, 2)    not null
#  display    :boolean          default(TRUE)
#  position   :integer          default(0)
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :memberships_package, class: 'Memberships::Package' do
    position 1
    title "MyString"
    cost "9.99"
    display false
  end
end
