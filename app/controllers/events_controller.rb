class EventsController < ApplicationController
  before_action :set_event, only: :show

  def index
    @presented_events = BaseCollectionPresenter.new(collection: Event.where('display = ? AND end_date <= ?', true, Date.today), view_template: view_context, presenter: EventPresenter)
  end

  def show
    redirect_to @event, status: :moved_permanently if event_path(@event) != request.path
    @presented_event = EventPresenter.new(object: @event, view_template: view_context)
  end

  private

  def set_event
    @event = Event.where('display = ? AND end_date <= ?', true, Date.today).friendly.find(params[:id])
  end
end
