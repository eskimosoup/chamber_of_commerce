module Optimadmin
  class InternalPromotionsController < Optimadmin::ApplicationController
    before_action :set_internal_promotion, only: [:show, :edit, :update, :destroy]

    edit_images_for InternalPromotion, [[:image, { homepage: ['limit', 728, 90] }]]

    def index
      @internal_promotions = InternalPromotion.where('name LIKE ?', "#{params[:search]}%").order(area: :asc).map{|x| Optimadmin::InternalPromotionPresenter.new(object: x, view_template: view_context) }
    end

    def show
    end

    def new
      @internal_promotion = InternalPromotion.new
    end

    def edit
    end

    def create
      @internal_promotion = InternalPromotion.new(internal_promotion_params)
      if @internal_promotion.save
        redirect_to internal_promotions_url, notice: 'Internal promotion was successfully created.'
      else
        render :new
      end
    end

    def update
      if @internal_promotion.update(internal_promotion_params)
        redirect_to internal_promotions_url, notice: 'Internal promotion was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @internal_promotion.destroy
      redirect_to internal_promotions_url, notice: 'Internal promotion was successfully destroyed.'
    end

  private


    def set_internal_promotion
      @internal_promotion = InternalPromotion.find(params[:id])
    end

    def internal_promotion_params
      params.require(:internal_promotion).permit(:name, :image, :image_cache, :remove_image, :remote_image_url, :link, :area, :display)
    end
  end
end
