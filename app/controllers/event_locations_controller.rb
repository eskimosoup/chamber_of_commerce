class EventLocationsController < ApplicationController
  def show
    @object = EventLocation.friendly.find(params[:id])
    return redirect_to @object, status: :moved_permanently if request.path != event_location_path(@object)

    @event_location = EventLocationPresenter.new(object: @object, view_template: view_context)
  end
end
