module Optimadmin
  class EventOfficesController < Optimadmin::ApplicationController
    before_action :set_event_office, only: [:show, :edit, :update, :destroy]

    def index
      @event_offices = Optimadmin::BaseCollectionPresenter.new(collection: EventOffice.where('name ILIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::EventOfficePresenter)
    end

    def show
    end

    def new
      @event_office = EventOffice.new
    end

    def edit
    end

    def create
      @event_office = EventOffice.new(event_office_params)
      if @event_office.save
        redirect_to event_offices_url, notice: 'Event office was successfully created.'
      else
        render :new
      end
    end

    def update
      if @event_office.update(event_office_params)
        redirect_to event_offices_url, notice: 'Event office was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @event_office.destroy
      redirect_to event_offices_url, notice: 'Event office was successfully destroyed.'
    end

  private


    def set_event_office
      @event_office = EventOffice.find(params[:id])
    end

    def event_office_params
      params.require(:event_office).permit(:name, :email)
    end
  end
end
