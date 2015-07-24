class Event < ActiveRecord::Base
  include Filterable

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  has_many :event_agendas, dependent: :destroy
  has_many :event_categories, through: :event_agendas
  belongs_to :event_location

  scope :event_location_id, -> (location_id) { where event_location_id: location_id }
  scope :event_categories_id, -> (event_categories_id) { joins(:event_categories).where event_categories: { id: event_categories_id } }
  scope :bookable, -> (bookable) { joins(:event_categories).where event_categories: { bookable: bookable } }
  scope :has_tables, -> (has_tables) { joins(:event_categories).where event_categories: { has_tables: has_tables } }
  scope :food_event, -> (food_event) { joins(:event_categories).where event_categories: { food_event: food_event } }
  scope :upcoming, -> { where('display = ? AND end_date >= ?', true, Date.today).order(start_date: :asc) }

  mount_uploader :image, EventUploader

  validates :name, :description, :start_date, :end_date, :event_location_id, presence: true
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

  def sensible_dates
    errors.add(:end_date, 'cannot be before the start date') if self.end_date.present? && self.start_date.present? && self.end_date < self.start_date
  end
end
