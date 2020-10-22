class EventBookingsController < ApplicationController

  before_action :set_event_and_agendas

  def new
    redirect_to @event, notice: "Bookings are no longer being taken for this event" if @event.booking_deadline.present? && @event.booking_deadline <= Time.zone.now
    @event_booking = @event.event_bookings.new
  end

  def create
    return redirect_to @event, notice: "Bookings are no longer being taken for this event" if @event.booking_deadline.present? && @event.booking_deadline <= Time.zone.now
    event_booking_creator = CreateEventBooking.new(@event, event_booking_params, current_administrator.present?)
    if event_booking_creator.save
      @event_booking = event_booking_creator.event_booking
      if event_booking_creator.paid?
        EventBookingMailer.booking_completed(@event_booking.email, @event_booking, @event_booking.event, true).deliver_now
        @event_booking.attendees.pluck(:email).each do |attendee_email|
          EventBookingMailer.booking_completed(attendee_email, @event_booking, @event_booking.event).deliver_now if attendee_email.present? && @event_booking.email != attendee_email
        end
        redirect_to @event, notice: "Thank you for your booking"
      elsif event_booking_creator.event_full?
        redirect_to full_event_path(@event)
      else
        redirect_to new_event_booking_charge_path(@event_booking)
      end
    else
      @event_booking = event_booking_creator.event_booking
      render :new
    end
  end

  private

  def set_event_and_agendas
    @event = Event.includes(:event_agendas).upcoming.friendly.find(params[:event_id])
    @presented_event = EventPresenter.new(object: @event, view_template: view_context)
  end

  def event_booking_params
    params.require(:event_booking).permit(:forename, :surname, :company_name, :industry, :nature_of_business, :address_line_1,
                                          :address_line_2, :town, :postcode, :phone_number, :email,
                                          attendees_attributes: [:id, :forename, :surname, :event_booking_id, :phone_number, :email,
                                                                 :dietary_requirements, :_destroy, event_agenda_ids: []])
  end

end
