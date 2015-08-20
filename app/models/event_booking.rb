class EventBooking < ActiveRecord::Base

  belongs_to :event, counter_cache: true

  has_many :attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees, reject_if: :all_blank, allow_destroy: true

  scope :paid, ->{ where(paid: true) }

  validates :name, :email, :phone_number, presence: true
  validates :attendees, presence: true
  validate :agendas_available, on: :create
  validates :stripe_charge_id, presence: true, on: :update

  def price
    attendee_prices.reduce(:+)
  end

  def stripe_price
    (price * 100).to_i
  end

  def agendas_available
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

  private

  def attendee_prices
    attendees.map(&:agendas_total_price)
  end

end
