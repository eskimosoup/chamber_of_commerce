module Optimadmin
  class EventAgendasController < Optimadmin::ApplicationController
    before_action :set_event, except: [:create, :edit, :update, :destroy]
    before_action :set_event_agenda, only: [:show, :edit, :update, :destroy]

    def index
      @event_agendas = Optimadmin::BaseCollectionPresenter.new(collection: EventAgenda.where("event_id = ? and name ILIKE ?", @event.id, "#{params[:search]}%").order(start_time: :desc).page(params[:page]).per(params[:per_page] || 15).order(params[:order]), view_template: view_context, presenter: Optimadmin::EventAgendaPresenter)
    end

    def show
    end

    def new
      @event_agenda = EventAgenda.new(event_id: @event.id)
    end

    def edit
      @event = @event_agenda.event
    end

    def create
      @event_agenda = EventAgenda.new(event_agenda_params)
      @event = Event.find(event_agenda_params[:event_id])
      if @event_agenda.save
        redirect_to event_agendas_url(event_id: @event_agenda.event_id), notice: 'Event agenda was successfully created.'
      else
        render :new
      end
    end

    def update
      @event = @event_agenda.event
      if @event_agenda.update(event_agenda_params)
        redirect_to event_agendas_url(event_id: @event.id), notice: 'Event agenda was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @event = @event_agenda.event
      @event_agenda.destroy
      redirect_to event_agendas_url(event_id: @event.id), notice: 'Event agenda was successfully destroyed.'
    end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_event_agenda
      @event_agenda = EventAgenda.find(params[:id])
    end

    def event_agenda_params
      params.require(:event_agenda).permit(:event_id, :name, :event_category_id, :start_time, :end_time, :description, :maximum_capacity, :price)
    end
  end
end
