class EventsController < ApplicationController
  before_action :set_event, except: :index

  def index
    @additional_content = AdditionalContentPresenter.new(object: AdditionalContent.find_by(area: 'Events - Index'), view_template: view_context)
    @presented_events = BaseCollectionPresenter.new(collection:
                        Event.upcoming.filter(params.slice(:event_location_id, :event_categories_id, :has_tables, :food_event)).page(params[:page]).per(params[:per_page] || 15),
                                                    view_template: view_context, presenter: EventPresenter)

    redirect_to(event_groups_path, status: 302)
  end

  def show
    redirect_to @presented_event, status: :moved_permanently if event_path(@presented_event) != request.path
    @presented_event_agendas = BaseCollectionPresenter.new(collection: @presented_event.event_agendas.includes(:event_category).order_by_start_time,
                                                           view_template: view_context, presenter: EventAgendaPresenter)
  end

  def thank_you
    redirect_to @presented_event, status: :moved_permanently if thank_you_event_path(@presented_event) != request.path
  end

  def full

  end

  private

  def set_event
    @presented_event = EventPresenter.new(object: Event.upcoming.admin(current_administrator).find(params[:id]), view_template: view_context)
  end
end
