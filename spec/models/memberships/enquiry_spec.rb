# == Schema Information
#
# Table name: memberships_enquiries
#
#  id                     :integer          not null, primary key
#  company_name           :string
#  email_address          :string
#  forename               :string
#  message                :text
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
require 'rails_helper'

RSpec.describe Memberships::Enquiry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
