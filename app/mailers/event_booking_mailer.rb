class EventBookingMailer < ApplicationMailer

  def booking_completed(event_booking, event)
    @event_booking = event_booking
    @event = event
    mail to: @event_booking.email, from: @event.event_office.email, bcc: @event.event_office.email, subject: "Booking Confirmation for #{ @event.name }"
  end
end
