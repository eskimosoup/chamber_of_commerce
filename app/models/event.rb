# == Schema Information
#
# Table name: events
#
#  id                               :integer          not null, primary key
#  allow_booking                    :boolean          default(TRUE)
#  booking_confirmation_information :text
#  booking_deadline                 :datetime
#  caption                          :string
#  description                      :text
#  display                          :boolean          default(TRUE)
#  end_date                         :date
#  event_agendas_count              :integer          default(0)
#  event_bookings_count             :integer          default(0)
#  eventbrite_link                  :string
#  fully_booked_content             :text
#  image                            :string
#  layout                           :string
#  name                             :string           not null
#  slug                             :string
#  start_date                       :date
#  suggested_url                    :string
#  summary                          :text
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  event_agendas_id                 :integer
#  event_location_id                :integer
#  event_office_id                  :integer
#
# Indexes
#
#  index_events_on_event_agendas_id   (event_agendas_id)
#  index_events_on_event_location_id  (event_location_id)
#  index_events_on_event_office_id    (event_office_id)
#
class Event < ActiveRecord::Base
  include Filterable, NullifyBlanks

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  has_many :event_agendas, dependent: :nullify
  has_many :event_categories, through: :event_agendas
  has_many :event_bookings, dependent: :nullify
  belongs_to :event_office
  belongs_to :event_location

  scope :event_location_id, -> (location_id) { where event_location_id: location_id }
  scope :event_categories_id, -> (event_categories_id) { includes(:event_categories).where event_categories: { id: event_categories_id } }
  #scope :bookable, -> (bookable) { where allow_booking: bookable }
  scope :has_tables, -> (has_tables) { includes(:event_categories).where event_categories: { has_tables: has_tables } }
  scope :food_event, -> (food_event) { includes(:event_categories).where event_categories: { food_event: food_event } }
  scope :upcoming, -> { where('display = :display AND ( end_date >= :date OR end_date is NULL )', display: true, date: Date.today).order(start_date: :asc) }
  scope :admin, -> (current_administrator) { unscoped if current_administrator.present? }

  mount_uploader :image, EventUploader

  validates :name, :description, :start_date, :event_location_id, :event_office_id, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { message: 'is not unique, leave this blank to generate automatically' }
  validate :sensible_dates

  def slug_candidates
    [
      :suggested_url,
      :name,
      [:suggested_url, :name]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || suggested_url_changed? || name_changed?
  end

  def self.layouts
    %w{ right_image full_image }
  end
  
  def sensible_dates
    errors.add(:end_date, 'cannot be before the start date') if self.end_date.present? && self.start_date.present? && self.end_date < self.start_date
  end
end
