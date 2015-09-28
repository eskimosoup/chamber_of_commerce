class EventBooking::PriceCalculator

  attr_accessor :attendees

  def initialize(attendees:)
    @attendees = attendees
  end

  def price
    return 0 if costs_for_agendas.empty?
    costs_for_agendas.reduce(:+).round(2)
  end

  def stripe_price
    (price * 100).to_i
  end

  def attendee_event_agendas
    @attendee_event_agendas ||= attendees.map(&:event_agendas).flatten
  end

  private

  def grouped_event_agendas
    @grouped_event_agendas ||= attendee_event_agendas.group_by{|x| x }
  end

  def agenda_attendees_price_calculators
    @price_calcs ||= grouped_event_agendas.map do |agenda, attendee_agendas|
      EventBooking::AgendaAttendeesPriceCalculator.new(event_agenda: agenda, number_of_attendees: attendee_agendas.size)
    end
  end

  def costs_for_agendas
    agenda_attendees_price_calculators.map(&:price)
  end

end