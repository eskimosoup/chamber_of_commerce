# Preview all emails at http://localhost:3000/rails/mailers/event_booking_mailer
class EventBookingMailerPreview < ActionMailer::Preview
  def booking_completed
    @event_booking = EventBooking.last
    @event = @event_booking.event
    EventBookingMailer.booking_completed(@event_booking.email, @event_booking, @event, true)
  end
end
