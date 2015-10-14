class EventBooking::AgendaAttendeesPriceCalculator

  attr_accessor :event_agenda, :number_of_attendees, :tables, :individuals
  def initialize(event_agenda:, number_of_attendees:)
    @event_agenda = event_agenda
    @number_of_attendees = number_of_attendees
    if event_agenda.table_size.zero?
      @tables = 0
      @individuals = number_of_attendees
    else
      @tables, @individuals = number_of_attendees.divmod(table_size)
    end

  end

  def price
    return 0 if number_of_attendees.zero?
    tables_price + individuals_price
  end

  def tables_price
    tables * price_per_table
  end

  def individuals_price
    agenda_price * individuals
  end

  def price_per_table
    if agenda_has_discount?
      agenda_discount_price * table_size
    else
      agenda_price * table_size
    end
  end

  private

  def agenda_discount_price
    agenda_price * decimal_discount
  end

  def agenda_price
    event_agenda.price
  end

  def agenda_has_discount?
    !event_agenda.table_discount.zero?
  end

  def discount_percentage
    (100 - event_agenda.table_discount)
  end

  def decimal_discount
    discount_percentage / 100
  end

  def table_size
    event_agenda.table_size
  end


end