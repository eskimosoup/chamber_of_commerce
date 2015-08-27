module Optimadmin
  class EventLocationsController < Optimadmin::ApplicationController
    before_action :set_event_location, only: [:show, :edit, :update, :destroy]

    def index
      @event_locations = Optimadmin::BaseCollectionPresenter.new(collection: EventLocation.where('location_name ILIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15).order(params[:order]), view_template: view_context, presenter: Optimadmin::EventLocationPresenter)
    end

    def show
    end

    def new
      @event_location = EventLocation.new
    end

    def edit
    end

    def create
      @event_location = EventLocation.new(event_location_params)
      if @event_location.save
        redirect_to event_locations_url, notice: 'Event location was successfully created.'
      else
        render :new
      end
    end

    def update
      if @event_location.update(event_location_params)
        redirect_to event_locations_url, notice: 'Event location was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @event_location.destroy
      redirect_to event_locations_url, notice: 'Event location was successfully destroyed.'
    end

  private


    def set_event_location
      @event_location = EventLocation.find(params[:id])
    end

    def event_location_params
      params.require(:event_location).permit(:address_line_1, :address_line_2, :city, :region, :post_code, :location_name)
    end
  end
end
