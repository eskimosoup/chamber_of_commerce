# == Schema Information
#
# Table name: magazines
#
#  id           :integer          not null, primary key
#  date         :date
#  display      :boolean          default(TRUE)
#  external_url :string
#  file         :string
#  image        :string
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryGirl.define do
  factory :magazine do
    name "name"
    date { Date.today }
  end
end
