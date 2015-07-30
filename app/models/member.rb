class Member < ActiveRecord::Base
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

  INDUSTRIES = ['Digital Sector', 'Accountant', 'Solicitor']


  def should_generate_new_friendly_id?
    slug.blank? || company_name_changed?
  end

  def self.title
    company_name
  end
end
