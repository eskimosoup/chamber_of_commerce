# == Schema Information
#
# Table name: additional_contents
#
#  id          :integer          not null, primary key
#  area        :string
#  button_link :string
#  button_text :text
#  content     :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class AdditionalContent < ActiveRecord::Base
  AREAS = [
    'Not used (hidden)',
    'Magazines - Index',
    'Events - Index',
    'Members - Index',
    'Members Area - Sign Up',
    'Members Area - Login',
    'Member Offers - Index',
    'App Banner',
    'Membership Banner',
    'Memberships/Homes - Index',
    'Memberships/Payments - Edit',
    'Memberships/Charges - New',
    'Memberships/Payments - Show'
  ].freeze.sort

  validates :area, uniqueness: true
  validates :area, :title, :content, presence: true
  validates :button_link, presence: true, if: :button_text?
  validates :button_text, presence: true, if: :button_link?

  def button?
    button_link? && button_text?
  end
end
