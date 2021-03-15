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
#  memberships_package_cost       :decimal(8, 2)
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
#  total_paid                     :decimal(8, 2)
#  twitter                        :string
#  vat_number                     :string
#  website                        :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  hashed_id                      :string
#  memberships_package_id         :integer
#  stripe_charge_id               :string
#  stripe_payment_intent_id       :string
#
# Indexes
#
#  index_memberships_payments_on_hashed_id               (hashed_id)
#  index_memberships_payments_on_memberships_package_id  (memberships_package_id)
#
# Foreign Keys
#
#  fk_rails_...  (memberships_package_id => memberships_packages.id)
#
require 'rails_helper'

RSpec.describe Memberships::Payment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
