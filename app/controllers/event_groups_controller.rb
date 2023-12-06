class EventGroupsController < ApplicationController
  def index
    @event_groups = EventGroup.displayed.ordered
  end

  def show
    @event_group = event_group
    @event_locations = filtered_events.map(&:event_location).uniq

    @presented_events = BaseCollectionPresenter.new(
      collection: filtered_events,
      view_template: view_context,
      presenter: EventPresenter
    )
  end

  private

  def filtered_events
    events.filter(params.slice(:event_location_id, :event_categories_id, :has_tables, :food_event)).page(params[:page]).per(params[:per_page] || 15)
  end

  def events
    event_group.events.upcoming
  end

  def event_group
    EventGroup.displayed.find(params[:id])
  end
end
