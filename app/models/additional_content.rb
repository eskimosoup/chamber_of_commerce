# == Schema Information
#
# Table name: additional_contents
#
#  id         :integer          not null, primary key
#  area       :string
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AdditionalContent < ActiveRecord::Base
  AREAS = [
    'Magazines - Index',
    'Events - Index',
    'Members - Index',
    'Members Area - Sign Up',
    'Members Area - Login',
    'Member Offers - Index',
    'App Banner',
    'Memberships/Homes - Index',
    'Memberships/Payments - Edit',
    'Memberships/Charges - New',
    'Memberships/Payments - Show'
  ]

  validates :area, uniqueness: true
  validates :area, :title, :content, presence: true
end
