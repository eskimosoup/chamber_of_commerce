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
  rescue ActiveRecord::StatementInvalid
    raise if Rails.env.development?

    head(:bad_request)
  end

  private

  def filtered_events
    events.filter(params.slice(:event_location_id, :event_categories_id, :has_tables, :food_event)).page(params[:page]).per(params[:per_page] || 15)
  end

  def events
    if event_group.area == 'International'
      ::Event.upcoming.where('events.id IN (?)', event_group_event_ids)
    else
      ::Event.upcoming.where('events.id IN (?) OR event_agendas_count = ?', event_group_event_ids, 0)
    end
  end

  def event_group_event_ids
    event_group.events.upcoming.ids
  end

  def event_group
    EventGroup.displayed.find(params[:id])
  end
end
