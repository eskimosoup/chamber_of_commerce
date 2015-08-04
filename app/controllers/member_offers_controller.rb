class MemberOffersController < ApplicationController
  before_action :members_only, except: [:index, :show]
  before_action :set_member_offer, only: :show
  before_action :set_member

  def index
    
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    redirect_to member_member_offer_path(@member_object, @member_offer_object), status: :moved_permanently if request.path != member_member_offer_path(@member_object, @member_offer_object)
  end

  def destroy
  end

  private

    def set_member
      @member_object = Member.find(params[:member_id])
      @presented_member = MemberPresenter.new(object: @member_object, view_template: view_context)
    end

    def set_member_offer
      @member_offer_object = MemberOffer.verified.find(params[:id])
      @presented_member_offer = MemberOfferPresenter.new(object: @member_offer_object, view_template: view_context)
    end
end
