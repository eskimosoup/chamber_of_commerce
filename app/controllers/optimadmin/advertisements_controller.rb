module Optimadmin
  class AdvertisementsController < Optimadmin::ApplicationController
    before_action :set_advertisement, only: %i[show edit update destroy]
    before_action :display_status, only: :index

    def index
      @advertisements = @all_items
                        .pagination(params[:page], params[:per_page])
    end

    def show; end

    def new
      @advertisement = Advertisement.new
    end

    def edit; end

    def create
      @advertisement = Advertisement.new(advertisement_params)
      if @advertisement.save
        redirect_to_index_or_continue_editing(@advertisement)
      else
        render :new
      end
    end

    def update
      if @advertisement.update(advertisement_params)
        redirect_to_index_or_continue_editing(@advertisement)
      else
        render :edit
      end
    end

    def destroy
      @advertisement.destroy
      if @advertisement.errors.present?
        redirect_to advertisements_url, flash: { error: @advertisement.errors.messages[:base].first }
      else
        redirect_to advertisements_url, notice: 'Advertisement was successfully destroyed.'
      end
    end

    private

    def display_status
      @all_items = Advertisement.field_order(params[:order])
                                .field_search(params[:search], 'name')
      @scheduled_items = @all_items.scheduled.pluck(:id)
      @published_items = @all_items.published.pluck(:id)
      @expired_items   = @all_items.expired.pluck(:id)
    end

    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    def advertisement_params
      params.require(:advertisement).permit(
        :name, :url, :image_large, :image_medium, :image_small, :publish_at,
        :expire_at, :remove_image_large, :remote_image_large_url,
        :image_large_cache, :remove_image_medium, :remote_image_medium_url,
        :image_medium_cache, :remove_image_small, :remote_image_small_url,
        :image_small_cache
      )
    end
  end
end
