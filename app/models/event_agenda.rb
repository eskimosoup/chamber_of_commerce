class EventAgenda < ActiveRecord::Base
  belongs_to :event_category
  belongs_to :event, counter_cache: true
  has_many :attendee_event_agendas, dependent: :nullify
  
  scope :order_by_start_time, ->{ order(start_time: :asc) }

  validates :name, :event_category, presence: true
  validates :table_size, numericality: { only_integer: true }
  validates :table_discount, numericality: true, allow_nil: true
  validate :sensible_times

  def open_spaces
    maximum_capacity - attendee_event_agendas_count
  end

  def full?(spaces_required)
    open_spaces < spaces_required
  end

  private

  def attendee_event_agendas_count
    attendee_event_agendas.count
  end

  def sensible_times
    errors.add(:end_time, 'cannot be before the start time') if self.end_time.present? && self.start_time.present? && self.end_time < self.start_time
  end
end
