class MemberOffersController < ApplicationController
  before_action :set_member, except: [:main_index]
  before_action :members_only, except: [:main_index, :index, :show]
  before_action :set_member_offer, only: :show
  before_action :current_member

  def main_index
    @additional_content = AdditionalContentPresenter.new(object: AdditionalContent.find_by(area: 'Member Offers - Index'), view_template: view_context)
    @member_offers = MemberOffer.filter(params.slice(:member_id)).current.verified.page(params[:page]).per(params[:per_page] || 15)
    @presented_member_offers = BaseCollectionPresenter.new(collection: @member_offers, view_template: view_context, presenter: MemberOfferPresenter)
  end

  def index
    @member_offers = BaseCollectionPresenter.new(collection: @member.member_offers.current.verified, view_template: view_context, presenter: MemberOfferPresenter)
    @expired_member_offers = BaseCollectionPresenter.new(collection: @member.member_offers.out_of_date_scope, view_template: view_context, presenter: MemberOfferPresenter) if current_member
    @unverified_member_offers = BaseCollectionPresenter.new(collection: @member.member_offers.unverified, view_template: view_context, presenter: MemberOfferPresenter) if current_member
    @upcoming_member_offers = BaseCollectionPresenter.new(collection: @member.member_offers.upcoming, view_template: view_context, presenter: MemberOfferPresenter) if current_member
  end

  def show
    redirect_to member_member_offer_url(@member, @member_offer), status: :moved_permanently if request.path != member_member_offer_path(@member, @member_offer)
  end

  def new
    @member_offer = current_member.member_offers.new
  end

  def edit
    @member_offer = @member.member_offers.find(params[:id])
  end

  def create
    @member_offer = current_member.member_offers.new(member_offer_params)
    if @member_offer.save
      MemberMailer.new_member_offer(global_site_settings, @member_offer).deliver_now
      redirect_to member_member_offer_url(@member, @member_offer), notice: 'Member offer was successfully created.'
    else
      render :new
    end
  end

  def update
    @member_offer = @member.member_offers.find(params[:id])
    if @member_offer.update(member_offer_params)
      MemberMailer.edited_member_offer(global_site_settings, @member_offer).deliver_now if @member_offer.verified
      redirect_to member_member_offer_url(@member, @member_offer), notice: 'Member offer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @member_offer = @member.member_offers.find(params[:id])
    @member_offer.destroy
    redirect_to member_member_offers_url(@member), notice: 'Member offer was successfully destroyed.'
  end

  private
    def member_offer_params
      params.require(:member_offer).permit(:title, :summary, :description, :website_link, :image, :start_date, :end_date, :remove_image)
    end

    def set_member
      @member = Member.find(params[:member_id])
      @presented_member = MemberPresenter.new(object: @member, view_template: view_context)
    end

    def set_member_offer
      @member_offer = MemberOffer.current.verified.find(params[:id]) unless current_member
      @member_offer = MemberOffer.find(params[:id]) if current_member
      @presented_member_offer = MemberOfferPresenter.new(object: @member_offer, view_template: view_context)
    end
end
