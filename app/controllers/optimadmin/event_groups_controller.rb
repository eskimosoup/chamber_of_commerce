module Optimadmin
  class EventGroupsController < Optimadmin::BaseController
    before_action :set_event_group, only: %i[show edit update destroy]

    def index
      @event_groups = ::EventGroup.field_order(params[:order] || 'position')
                                  .field_search(params[:search])
                                  .pagination(params[:page], params[:per_page])
    end

    def show; end

    def new
      @event_group = ::EventGroup.new
    end

    def edit; end

    def create
      @event_group = ::EventGroup.new(event_group_params)
      if @event_group.save
        redirect_to_index_or_continue_editing(@event_group)
      else
        render(:new)
      end
    end

    def update
      if @event_group.update(event_group_params)
        redirect_to_index_or_continue_editing(@event_group)
      else
        render(:edit)
      end
    end

    def destroy
      if @event_group.destroy
        redirect_back(fallback_location: { action: :index }, notice: t('optimadmin.controllers.module.destroy', model_name: ::EventGroup.model_name.human))
      else
        redirect_back(fallback_location: { action: :index }, flash: { error: @event_group.errors.messages[:base].first })
      end
    end

    private

    def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
      redirect_to(fallback_location, notice: (flash.present? ? flash[:error] : notice))
    end

    def set_event_group
      @event_group = ::EventGroup.find(params[:id])
    end

    def event_group_params
      params.require(:event_group).permit(
        :position,
        :title,
        :display,
        :area,
        :summary,
        :content,
        event_category_ids: []
      )
    end
  end
end
