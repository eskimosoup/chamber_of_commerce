# == Schema Information
#
# Table name: memberships_enquiries
#
#  id                     :integer          not null, primary key
#  company_name           :string
#  email_address          :string
#  forename               :string
#  postcode               :string
#  surname                :string
#  telephone              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  memberships_package_id :integer
#
# Indexes
#
#  index_memberships_enquiries_on_memberships_package_id  (memberships_package_id)
#
# Foreign Keys
#
#  fk_rails_...  (memberships_package_id => memberships_packages.id)
#
FactoryGirl.define do
  factory :memberships_enquiry, class: 'Memberships::Enquiry' do
    forename "MyString"
    surname "MyString"
    telephone "MyString"
    email_address "MyString"
    company_name "MyString"
    postcode "MyString"
    memberships_package nil
  end
end
