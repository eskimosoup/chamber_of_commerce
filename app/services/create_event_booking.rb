class CreateEventBooking
  # Create Event Booking
  # Set paid if event booking is free
  attr_reader :event, :event_booking, :params, :administrator

  def initialize(event, params, administrator = false)
    @event = event
    @params = params
    @event_booking = event.event_bookings.new(params)
    @administrator = administrator
  end

  def save
    set_paid
    set_payment_method
    if event_booking.save
      true
    else
      false
    end
  end

  def paid?
    event_booking.paid?
  end

  private

  def administrator?
    administrator
  end

  def set_paid
    if event_booking.price.zero? || administrator?
      event_booking.paid = true
    end
  end

  def set_payment_method
    event_booking.payment_method = payment_method
  end

  def payment_method
    if event_booking.price.zero?
      "N/A"
    elsif administrator?
      "Offline"
    else
      "Stripe"
    end
  end

end