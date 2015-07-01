module Optimadmin
  class EventCategoriesController < Optimadmin::ApplicationController
    before_action :set_event_category, only: [:show, :edit, :update, :destroy]

    def index
      @event_categories = Optimadmin::BaseCollectionPresenter.new(collection: EventCategory.roots.order(position: :asc).page(params[:page]).per(15), view_template: view_context, presenter: Optimadmin::EventCategoryPresenter)
    end

    def show
    end

    def new
      @event_category = EventCategory.new
    end

    def edit
    end

    def create
      @event_category = EventCategory.new(event_category_params)
      if @event_category.save
        redirect_to event_categories_url, notice: 'Event category was successfully created.'
      else
        render :new
      end
    end

    def update
      if @event_category.update(event_category_params)
        redirect_to event_categories_url, notice: 'Event category was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @event_category.destroy
      redirect_to event_categories_url, notice: 'Event category was successfully destroyed.'
    end

  private


    def set_event_category
      @event_category = EventCategory.friendly.find(params[:id])
    end

    def event_category_params
      params.require(:event_category).permit(:parent_id, :name, :has_tables, :food_event, :bookable, :suggested_url)
    end
  end
end
