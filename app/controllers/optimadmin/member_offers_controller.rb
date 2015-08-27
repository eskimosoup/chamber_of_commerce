module Optimadmin
  class MemberOffersController < Optimadmin::ApplicationController

    edit_images_for MemberOffer, [[:image, { index: ['fill', 250, 250], show: ['fill', 215, 135], homepage: ['fill', 450, 295] }]]
    before_action :set_member_offer, only: [:show, :edit, :update, :destroy]

    def index
      @member_offers = Optimadmin::BaseCollectionPresenter.new(collection: MemberOffer.where('title ILIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15).order(params[:order] || "verified asc"), view_template: view_context, presenter: Optimadmin::MemberOfferPresenter)
    end

    def show
    end

    def new
      @member_offer = MemberOffer.new
    end

    def edit
    end

    def create
      @member_offer = MemberOffer.new(member_offer_params)
      if @member_offer.save
        redirect_to member_offers_url, notice: 'Member offer was successfully created.'
      else
        render :new
      end
    end

    def update
      if @member_offer.update(member_offer_params)
        redirect_to member_offers_url, notice: 'Member offer was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @member_offer.destroy
      redirect_to member_offers_url, notice: 'Member offer was successfully destroyed.'
    end

  private


    def set_member_offer
      @member_offer = MemberOffer.find(params[:id])
    end

    def member_offer_params
      params.require(:member_offer).permit(:member_id, :title, :summary, :description, :website_link, :image, :start_date, :end_date, :verified)
    end
  end
end
