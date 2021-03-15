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

require_dependency 'memberships'

module Memberships
  class Enquiry < ActiveRecord::Base
    include OptimadminScopes

    belongs_to :package,
               foreign_key: :memberships_package_id,
               class_name: '::Memberships::Package'
    delegate :title, to: :package, prefix: true, allow_nil: true

    validates :memberships_package_id, presence: true
    validates :forename, presence: true
    validates :surname, presence: true
    validates :telephone, presence: true
    validates :company_name, presence: true
    validates :postcode, presence: true
    validates :email_address, presence: true, email: true
    validates :message, presence: true

    def full_name
      [forename, surname].join(' ')
    end
  end
end
