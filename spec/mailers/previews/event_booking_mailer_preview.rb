# Preview all emails at http://localhost:3000/rails/mailers/event_booking_mailer
class EventBookingMailerPreview < ActionMailer::Preview
  def booking_completed
    @event_booking = EventBooking.first
    @event = @event_booking.event
    EventBookingMailer.booking_completed(@event_booking, @event)
  end
end
