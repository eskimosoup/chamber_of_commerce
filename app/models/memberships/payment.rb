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

require_dependency 'memberships'

module Memberships
  class Payment < ActiveRecord::Base
    include OptimadminScopes
    include ObfuscateIds

    has_many :payment_how_heards,
             class_name: '::Memberships::PaymentHowHeard',
             foreign_key: :memberships_payment_id,
             dependent: :nullify
    has_many :how_heards, through: :payment_how_heards

    has_many :payment_join_reasons,
             class_name: '::Memberships::PaymentJoinReason',
             foreign_key: :memberships_payment_id,
             dependent: :nullify
    has_many :join_reasons, through: :payment_join_reasons

    belongs_to :package,
               foreign_key: :memberships_package_id,
               class_name: '::Memberships::Package',
               inverse_of: :payments
    delegate :title, :cost, to: :package, prefix: true

    LEGAL_STATUSES = [
      'Plc',
      'Ltd',
      'LLP',
      'CiC',
      'Charity',
      'Partnership',
      'Sole trader',
      'School'
    ].freeze
    public_constant :LEGAL_STATUSES

    validates :memberships_package_id, presence: true
    validates :address_line_1, presence: true
    validates :business_start_date, presence: true
    validates :business_activity, presence: true
    validates :telephone, presence: true

    validates :primary_contact_email_address,
              presence: true,
              email: true,
              on: :update

    validates :accounts_contact_email_address,
              presence: true,
              email: true,
              on: :update

    validates :primary_contact_title,
              presence: true,
              on: :update

    validates :primary_contact_forename,
              presence: true,
              on: :update

    validates :primary_contact_surname,
              presence: true,
              on: :update

    validates :primary_contact_role,
              presence: true,
              on: :update

    validates :primary_contact_telephone,
              presence: true,
              on: :update

    validates :accounts_contact_forename,
              presence: true,
              on: :update

    validates :accounts_contact_surname,
              presence: true,
              on: :update

    validates :accounts_contact_role,
              presence: true,
              on: :update

    validates :accounts_contact_telephone,
              presence: true,
              on: :update

    validates :accounts_contact_title,
              presence: true,
              on: :update

    validates :company_name, presence: true
    validates :postcode, presence: true
    validates :legal_status, inclusion: { in: LEGAL_STATUSES }

    before_save :set_static_amounts, if: :new_record?

    #
    # Primary contact
    #
    # @return [string]
    #
    def primary_contact
      [
        primary_contact_title,
        primary_contact_forename,
        primary_contact_surname
      ].join(' ')
    end

    #
    # Accounts contact
    #
    # @return [string]
    #
    def accounts_contact
      [
        accounts_contact_title,
        accounts_contact_forename,
        accounts_contact_surname
      ].join(' ')
    end

    #
    # Address
    #
    # @return [string]
    #
    def address_fields
      [address_line_1, address_line_2, city, county, postcode].join(' ')
    end

    #
    # Stripe price (inc VAT)
    #
    # @return [integer]
    #
    def stripe_price
      (total_inc_vat * 100).to_i
    end

    #
    # Total VAT
    #
    # @return [integer]
    #
    def total_vat
      (memberships_package_cost * 0.2)
    end

    #
    # Total ex. VAT
    #
    # @return [integer]
    #
    def total_ex_vat
      memberships_package_cost
    end

    #
    # Total inc. VAT
    #
    # @return [integer]
    #
    def total_inc_vat
      memberships_package_cost + total_vat
    end

    #
    # How heard titles
    #
    # @return [string]
    #
    def how_heard_titles
      how_heards.map(&:title).join(', ')
    end

    #
    # How heard titles
    #
    # @return [string]
    #
    def join_reason_titles
      join_reasons.map(&:title).join(', ')
    end

    private

    def set_static_amounts
      self.memberships_package_cost = package_cost
      self.memberships_package_title = package_title
    end
  end
end
