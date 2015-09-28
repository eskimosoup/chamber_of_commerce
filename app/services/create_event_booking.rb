class CreateEventBooking
  # Create Event Booking
  # Set paid if event booking is free
  attr_reader :event, :event_booking, :params

  def initialize(event, params)
    @event = event
    @params = params
    @event_booking = event.event_bookings.new(params)
  end

  def save
    event_booking.paid = true if event_booking.price.zero?
    if event_booking.save
      true
    else
      false
    end
  end

  def paid?
    event_booking.paid?
  end

end