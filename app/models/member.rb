class Member < ActiveRecord::Base
  default_scope { where(in_csv: true) }

  include Filterable
  extend FriendlyId
  friendly_id :company_name, use: [:slugged, :history]

  has_many :member_login, dependent: :destroy
  has_many :member_offers, dependent: :destroy
  has_many :member_industries, dependent: :destroy
  has_many :industries, through: :member_industries


  #validates :company_name, :address, :telephone,
            #:nature_of_business, presence: true

  #validates :company_name, uniqueness: true
  #validates :email, email: true, allow_blank: true
  validates :company_name, presence: true

  scope :company_name, -> (company_name) { where("company_name ILIKE ?", "%#{company_name}%") if company_name.present? }
  #scope :nature_of_business, -> (nature_of_business) { where("nature_of_business ILIKE ?", "#{nature_of_business}%") }
  #scope :industry, -> (industry_id) { joins(:industries).where(industries: { id: industry_id }) }
  scope :verified, -> { where(verified: true) }
  scope :admin, -> (current_administrator) { unscoped if current_administrator.present? }

  def should_generate_new_friendly_id?
    slug.blank? || company_name_changed?
  end

  def title
    company_name
  end

  def self.search_terms(search_terms)
    if search_terms.present?
      joins(:industries).where(
        "nature_of_business ILIKE :search_terms
          OR industries.name ILIKE :search_terms
          OR members.company_name ILIKE :search_terms
        ",
        search_terms: "%#{search_terms}%"
      )
    end
  end

end
