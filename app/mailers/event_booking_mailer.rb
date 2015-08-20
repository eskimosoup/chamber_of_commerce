class EventBookingMailer < ApplicationMailer

  def booking_completed(event_booking, event)
    @event_booking = event_booking
    @event = event
    mail to: @event_booking.email, subject: "Booking Confirmation for #{ @event.name }"
  end
end
