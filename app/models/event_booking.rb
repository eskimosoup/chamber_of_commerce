class EventBooking < ActiveRecord::Base

  belongs_to :event, counter_cache: true
  has_many :event_agendas, through: :event
  has_many :attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees, reject_if: :all_blank, allow_destroy: true

  scope :paid, ->{ where(paid: true) }

  validates :forename, :surname, :email, :phone_number, presence: true
  validates :attendees, presence: true
  validate :agendas_available, on: :create
  validates :stripe_charge_id, presence: true, on: :update, unless: :paid?

  def price
    price_calculator.price
  end

  def stripe_price
    price_calculator.stripe_price
  end

  def agendas_available
    return nil if event.blank? || event.event_agendas.blank?
    event.event_agendas.each do |event_agenda|
      errors.add(:base, "#{ event_agenda.name } only has #{ event_agenda.open_spaces } spaces") if event_agenda.full?(agenda_id_frequency[event_agenda.id])
    end
  end

  def attendee_event_agenda_ids
    attendees.map(&:agenda_ids).flatten
  end

  def agenda_id_frequency
    @agenda_id_frequency ||= attendee_event_agenda_ids.each_with_object(Hash.new(0)) {|id, result| result[id] += 1 }
  end

  def attendees_csv_attributes
    attendees.map(&:csv_attributes).flatten
  end

  def self.to_csv(event_id:)
    attributes = %w{ forename surname company_name industry nature_of_business address_line_1 address_line_2 town postcode
                phone_number email paid refunded }
    attendee_attributes = Attendee::CSV_FIELDS
    headers = attributes + (attendee_attributes * max_attendees(event_id: event_id))
    CSV.generate(headers: true) do |csv|
      csv << headers
      includes(:attendees).where(event_id: event_id).each do |booking|
        row = booking.attributes.values_at(*attributes)
        row.push(*booking.attendees_csv_attributes)
        csv << row
      end
    end
  end

  def self.max_attendees(event_id:)
    where(event_id: event_id).maximum(:attendees_count)
  end

  private

  def price_calculator
    EventBooking::PriceCalculator.new(attendees: attendees)
  end

end
