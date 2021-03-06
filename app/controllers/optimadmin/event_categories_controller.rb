module Optimadmin
  class EventCategoriesController < Optimadmin::ApplicationController
    before_action :set_event_category, only: [:show, :edit, :update, :destroy]

    def index
      @event_categories = Optimadmin::BaseCollectionPresenter.new(collection: EventCategory.roots.where('name ILIKE ?', "%#{params[:search]}%").order(position: :asc).page(params[:page]).per(params[:per_page] || 15).order(params[:order]), view_template: view_context, presenter: Optimadmin::EventCategoryPresenter)
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
        redirect_to_index_or_continue_editing(@event_category)
      else
        render :new
      end
    end

    def update
      if @event_category.update(event_category_params)
        redirect_to_index_or_continue_editing(@event_category)
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
      @event_category = EventCategory.find(params[:id])
    end

    def event_category_params
      params.require(:event_category).permit(:parent_id, :name, :has_tables, :food_event, :bookable, :suggested_url)
    end
  end
end
