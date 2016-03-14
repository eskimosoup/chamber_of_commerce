class EventAgenda < ActiveRecord::Base
  belongs_to :event_category
  belongs_to :event, counter_cache: true
  has_many :attendee_event_agendas, dependent: :nullify
  has_many :attendees, through: :attendee_event_agendas

  scope :order_by_start_time, -> { order(start_time: :asc) }

  validates :name, :event_category, :price, presence: true
  validates :table_size, numericality: { only_integer: true }
  validates :table_discount, numericality: true, allow_nil: false, presence: true
  validate :sensible_times

  def open_spaces
    maximum_capacity - attendee_event_agendas_count
  end

  def full?(spaces_required)
    open_spaces < spaces_required
  end

  def self.csv_headers
    headers = EventBooking::CSV_HEADERS
    headers << 'Agenda'
    headers.push(*Attendee::CSV_HEADERS)
    headers
  end

  def self.to_csv(event_id)
    CSV.generate(headers: true) do |csv|
      csv << csv_headers
      includes(attendees: :event_booking).where(event_id: event_id).each do |agenda|
        agenda.attendees.each do |attendee|
          next if attendee.event_booking.paid != true || attendee.event_booking.refunded == true
          row = attendee.event_booking.csv_attributes
          row << agenda.name
          row.push(*attendee.csv_attributes)
          csv << row
        end
      end
    end
  end

  private

  def attendee_event_agendas_count
    attendee_event_agendas.joins(attendee: :event_booking).where(event_bookings: { paid: true, refunded: false }).count
  end

  def sensible_times
    errors.add(:end_time, 'cannot be before the start time') if end_time.present? && start_time.present? && end_time < start_time
  end
end
