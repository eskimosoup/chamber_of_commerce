class EventBookingsController < ApplicationController

  before_action :set_event_and_agendas

  def new
    @event_booking = @event.event_bookings.new
  end

  def create
    event_booking_creator = CreateEventBooking.new(@event, event_booking_params)
    if event_booking_creator.save
      if event_booking_creator.paid?
        redirect_to @event, notice: "Thank you for your booking"
      else
        redirect_to new_event_booking_charge_path(event_booking_creator.event_booking)
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