class Attendee < ActiveRecord::Base
  belongs_to :event_booking, counter_cache: true
  has_many :attendee_event_agendas, dependent: :destroy
  has_many :event_agendas, through: :attendee_event_agendas

  validates :attendee_event_agendas, presence: true

  def agendas_total_price
    attendee_event_agenda_prices.reduce(:+)
  end

  def agenda_ids
    attendee_event_agendas.map(&:event_agenda_id)
  end

  def csv_attributes
    %w{ phone_number email dietary_requirements event_agenda_names }.map{|attr| send(attr) }
  end

  def event_agenda_names
    event_agendas.pluck(:name).join(", ")
  end

  private

  def attendee_event_agenda_prices
    attendee_event_agendas.map(&:price)
  end

end
