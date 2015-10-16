class Member < ActiveRecord::Base
  include Filterable
  extend FriendlyId
  friendly_id :company_name, use: [:slugged, :history]

  has_one :member_login, dependent: :destroy
  has_many :member_offers, dependent: :destroy
  has_many :member_industries, dependent: :destroy
  has_many :industries, through: :member_industries


  #validates :company_name, :address, :telephone,
            #:nature_of_business, presence: true

  #validates :company_name, uniqueness: true
  #validates :email, email: true, allow_blank: true
  validates :company_name, presence: true

  scope :company_name, -> (company_name) { where("company_name ILIKE ?", "%#{company_name}%") if company_name.present? }
  # http://stackoverflow.com/a/29798772
  scope :search_terms, -> (search_terms) {
    joins(:industries).where("nature_of_business ~* :search_terms OR industries.name ~* :search_terms", search_terms: "\\y#{search_terms}\\y") if search_terms.present?
  }
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

end
