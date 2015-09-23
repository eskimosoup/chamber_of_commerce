class EventBookingsController < ApplicationController

  before_action :set_event_and_agendas

  def new
    @event_booking = @event.event_bookings.new
  end

  def create
    @event_booking = @event.event_bookings.new(event_booking_params)
    if @event_booking.save
      redirect_to new_event_booking_charge_path(@event_booking)
    else
      render :new
    end
  end

  private

  def set_event_and_agendas
    @event = Event.includes(:event_agendas).upcoming.friendly.find(params[:event_id])
    @presented_event = EventPresenter.new(object: @event, view_template: view_context)
  end

  def event_booking_params
    params.require(:event_booking).permit(:name, :company_name, :industry, :nature_of_business, :address_line_1,
                                          :address_line_2, :town, :postcode, :phone_number, :email,
                                          attendees_attributes: [:id, :event_booking_id, :phone_number, :email,
                                                                 :dietary_requirements, :_destroy, event_agenda_ids: []])
  end

end