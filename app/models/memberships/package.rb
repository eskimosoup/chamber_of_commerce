# == Schema Information
#
# Table name: memberships_packages
#
#  id                  :integer          not null, primary key
#  cost                :decimal(8, 2)    not null
#  display             :boolean          default(TRUE)
#  position            :integer          default(0)
#  special_offer_price :decimal(8, 2)
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require_dependency 'memberships'

module Memberships
  class Package < ActiveRecord::Base
    include OptimadminScopes

    scope :ordered, -> { order(:position) }
    scope :displayed, -> { where(display: true) }

    validates :title, presence: true
    validates :cost, presence: true

    has_many :enquiries,
             dependent: :restrict_with_error,
             class_name: '::Memberships::Enquiry',
             foreign_key: :memberships_package_id,
             inverse_of: :package

    has_many :payments,
             dependent: :nullify,
             class_name: '::Memberships::Payment',
             foreign_key: :memberships_package_id,
             inverse_of: :package

    def price
      special_offer_price? ? special_offer_price : cost
    end
  end
end
