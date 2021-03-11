# == Schema Information
#
# Table name: member_logins
#
#  id                   :integer          not null, primary key
#  active               :boolean          default(TRUE)
#  auth_token           :string
#  contact_name         :string
#  password_digest      :string
#  password_reset_token :string
#  username             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  member_id            :integer
#
# Indexes
#
#  index_member_logins_on_member_id  (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => members.id)
#
FactoryGirl.define do
  factory :member_login do
    member
    contact_name "contact name"
    username "username"
    password "password"
  end
end
