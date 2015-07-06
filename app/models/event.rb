class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  has_many :event_agendas, dependent: :destroy
  has_many :event_categories, through: :event_agendas
  belongs_to :event_location

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

  def self.upcoming_bookable
    joins(:event_categories).where('display = ? AND event_categories.bookable = ? AND end_date >= ?', true, true, Date.today).order(start_date: :asc)
  end
end
