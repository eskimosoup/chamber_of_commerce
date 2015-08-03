class EventBookingsController < ApplicationController

  before_action :set_event_and_agendas

  def new
    @event_booking = @presented_event.event_bookings.new
  end

  def create

  end

  private

  def set_event_and_agendas
    @presented_event = EventPresenter.new(object: Event.upcoming.find(params[:id]), view_template: view_context)

  end

end