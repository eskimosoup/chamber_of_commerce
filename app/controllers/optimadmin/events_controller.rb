module Optimadmin
  class EventsController < Optimadmin::ApplicationController
    edit_images_for Event, [[:image, { index: ['fill', 218, 135], show: ['fit', 218, 9999], homepage: ['fill', 418, 280] }]]
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    def index
      @events = Optimadmin::BaseCollectionPresenter.new(collection: Event.where('name ILIKE ?', "%#{params[:search]}%").order(start_date: :desc).page(params[:page]).per(params[:per_page] || 15).order(params[:order] || "created_at desc"), view_template: view_context, presenter: Optimadmin::EventPresenter)
    end

    def show
    end

    def new
      @event = Event.new
    end

    def edit
    end

    def create
      @event = Event.new(event_params)
      if @event.save
        redirect_to events_url, notice: 'Event was successfully created.'
      else
        render :new
      end
    end

    def update
      if @event.update(event_params)
        redirect_to events_url, notice: 'Event was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully destroyed.'
    end

  private


    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :event_agendas, :start_date, :end_date, :remote_image_url, :image_cache,
                                    :remove_image, :image, :event_location_id, :description, :display, :summary,
                                    :booking_confirmation_information, :eventbrite_link)
    end
  end
end
