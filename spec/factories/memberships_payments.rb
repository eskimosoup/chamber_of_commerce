# == Schema Information
#
# Table name: memberships_payments
#
#  id                             :integer          not null, primary key
#  accounts_contact_email_address :string
#  accounts_contact_forename      :string
#  accounts_contact_role          :string
#  accounts_contact_surname       :string
#  accounts_contact_telephone     :string
#  accounts_contact_title         :string
#  address_line_1                 :string
#  address_line_2                 :string
#  business_activity              :string
#  business_start_date            :date
#  city                           :string
#  company_name                   :string           not null
#  company_number                 :string
#  county                         :string
#  facebook                       :string
#  instagram                      :string
#  legal_status                   :string
#  linkedin                       :string
#  memberships_package_cost       :decimal(, )
#  memberships_package_title      :string
#  number_of_employees            :integer
#  paid                           :boolean          default(FALSE)
#  postcode                       :string
#  primary_contact_email_address  :string
#  primary_contact_forename       :string
#  primary_contact_role           :string
#  primary_contact_surname        :string
#  primary_contact_telephone      :string
#  primary_contact_title          :string
#  telephone                      :string
#  total_paid                     :decimal(, )
#  twitter                        :string
#  vat_number                     :string
#  website                        :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  hashed_id                      :string
#  memberships_how_heard_id       :integer
#  memberships_package_id         :integer
#  stripe_charge_id               :string
#  stripe_payment_intent_id       :string
#
# Indexes
#
#  index_memberships_payments_on_hashed_id                 (hashed_id)
#  index_memberships_payments_on_memberships_how_heard_id  (memberships_how_heard_id)
#  index_memberships_payments_on_memberships_package_id    (memberships_package_id)
#
# Foreign Keys
#
#  fk_rails_...  (memberships_how_heard_id => memberships_how_heards.id)
#  fk_rails_...  (memberships_package_id => memberships_packages.id)
#
FactoryGirl.define do
  factory :memberships_payment, class: 'Memberships::Payment' do
    company_name "MyString"
    address_line_1 "MyString"
    address_line_2 "MyString"
    city "MyString"
    county "MyString"
    postcode "MyString"
    business_activity "MyString"
    number_of_employees 1
    website "MyString"
    telephone "MyString"
    legal_status "MyString"
    business_start_date "2021-03-11"
    linkedin "MyString"
    twitter "MyString"
    facebook "MyString"
    instagram "MyString"
    primary_contact_title "MyString"
    primary_contact_forename "MyString"
    primary_contact_surname "MyString"
    primary_contact_role "MyString"
    primary_contact_telephone "MyString"
    primary_contact_email_address "MyString"
    company_number "MyString"
    vat_number "MyString"
    accounts_contact_title "MyString"
    accounts_contact_forename "MyString"
    accounts_contact_surname "MyString"
    accounts_contact_role "MyString"
    accounts_contact_telephone "MyString"
    accounts_contact_email_address "MyString"
    memberships_package_id nil
    memberships_package_title "MyString"
    memberships_package_cost "9.99"
    total_paid "9.99"
    paid false
    stripe_charge_id "MyString"
    stripe_payment_intent_id "MyString"
    hashed_id "MyString"
  end
end
