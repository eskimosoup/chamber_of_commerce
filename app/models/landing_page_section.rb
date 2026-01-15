# == Schema Information
#
# Table name: landing_page_sections
#
#  id              :integer          not null, primary key
#  area            :string           not null
#  button_link     :string
#  button_text     :string
#  content         :text
#  display         :boolean          default(TRUE)
#  image           :string
#  position        :integer          default(0)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  landing_page_id :integer
#
# Indexes
#
#  index_landing_page_sections_on_area             (area)
#  index_landing_page_sections_on_landing_page_id  (landing_page_id)
#
# Foreign Keys
#
#  fk_rails_...  (landing_page_id => landing_pages.id)
#
class LandingPageSection < ActiveRecord::Base
# Structure consistently, using
  # @see https://rails.rubystyle.guide/#macro-style-methods

  # Concerns
  include OptimadminScopes

  # Scopes
  scope :ordered, -> { order(:area, :position) }
  scope :displayed, -> { where(display: true) }

  # Constants
  AREAS = [
    'Expo/Event - Item',
    'Expo/Testimonial - Item',
    'Expo/Sponsor - Item'
  ].sort.freeze
  public_constant :AREAS

  # enums

  # Associations
  belongs_to :landing_page

  # Validations
  with_options(presence: true) do
    validates :area, inclusion: { in: AREAS }
    validates :button_link, if: :button_text?
    validates :button_text, if: :button_link?
  end

  # Callbacks

  # Other methods
  mount_uploader :image, LandingPageSectionUploader

  #
  # Button?
  #
  # @return [boolean]
  #
  def button?
    button_link? && button_text?
  end
end
