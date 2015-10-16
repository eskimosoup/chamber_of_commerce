class EventBookingMailer < ApplicationMailer

  def booking_completed(email_to, event_booking, event, bcc = false)
    @event_booking = event_booking
    @event = event

    if bcc == true
      mail to: email_to, from: @event.event_office.email, bcc: @event.event_office.email, subject: "Booking Confirmation for #{ @event.name }"
    else
      mail to: email_to, from: @event.event_office.email, subject: "Booking Confirmation for #{ @event.name }"
    end
  end

  def booking_refunded(event_booking)
    @event_booking = event_booking
    @event = @event_booking.event
    mail to: @event_booking.email, from: @event.event_office.email, bcc: @event.event_office.email,
         subject: "Confirmation of refund for #{ @event.name }"
  end
end
