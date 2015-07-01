class EventLocationsController < ApplicationController
  def show
    @object = EventLocation.friendly.find(params[:id])
    @event_location = EventLocationPresenter.new(object: @object, view_template: view_context)
    if request.path != event_location_path(@object)
      return redirect_to @object, status: :moved_permanently
    end
  end
end
