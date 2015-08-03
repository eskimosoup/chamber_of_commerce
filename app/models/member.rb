class Member < ActiveRecord::Base
  include Filterable

  validates :company_name,
            :industry,
            :address,
            :telephone,
            :website,
            :email,
            :nature_of_business, presence: true

  validates :company_name, uniqueness: true
  validates :email, email: true

  extend FriendlyId
  friendly_id :company_name, use: [:slugged, :history]

  has_one :member_login
  has_many :member_offers

  INDUSTRIES = ['Digital Sector', 'Accountant', 'Solicitor']

  scope :company_name, -> (company_name) { where("company_name LIKE ?", "#{company_name}%") }
  scope :nature_of_business, -> (nature_of_business) { where("nature_of_business LIKE ?", "%#{nature_of_business}%") }
  scope :industry, -> (industry) { where("industry = ?", industry) }

  def should_generate_new_friendly_id?
    slug.blank? || company_name_changed?
  end

  def self.title
    company_name
  end
end
