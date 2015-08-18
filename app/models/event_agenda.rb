class EventAgenda < ActiveRecord::Base
  belongs_to :event_category
  belongs_to :event, counter_cache: true
  has_many :attendee_event_agendas, dependent: :nullify

  scope :order_by_start_time, ->{ order(start_time: :asc) }

  validates :name, :event_category, :description, presence: true
  validate :sensible_times

  private

  def sensible_times
    errors.add(:end_time, 'cannot be before the start time') if self.end_time.present? && self.start_time.present? && self.end_time < self.start_time
  end
end
