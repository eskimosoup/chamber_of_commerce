class EventsController < ApplicationController
  before_action :set_event, only: :show

  def index
    @additional_content = AdditionalContentPresenter.new(object: AdditionalContent.find_by(area: 'Events - Index'), view_template: view_context)
    @presented_events = BaseCollectionPresenter.new(collection:
                        Event.upcoming_bookable.joins(:event_agendas).filter(params.slice(:event_location_id, :event_categories_id, :bookable, :has_tables, :food_event)).page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: EventPresenter
                        )
  end

  def show
    redirect_to @event, status: :moved_permanently if event_path(@event) != request.path
    @presented_event = EventPresenter.new(object: @event, view_template: view_context)
  end

  private

  def set_event
    @event = Event.where('display = ? AND end_date >= ?', true, Date.today).friendly.find(params[:id])
  end
end
