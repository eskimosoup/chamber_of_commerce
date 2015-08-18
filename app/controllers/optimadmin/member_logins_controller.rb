module Optimadmin
  class MemberLoginsController < Optimadmin::ApplicationController
    before_action :set_member
    before_action :set_member_login, only: [:show, :edit, :update, :destroy]

    def index
      @member_logins = Optimadmin::BaseCollectionPresenter.new(collection: MemberLogin.where('title ILIKE ?', "#{params[:search]}").page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: Optimadmin::MemberLoginPresenter)
    end

    def show
    end

    def new
      @member_login = MemberLogin.new
    end

    def edit
    end

    def create
      @member_login = MemberLogin.new(member_login_params)
      if @member_login.save
        redirect_to members_url, notice: 'Member login was successfully created.'
      else
        render :new
      end
    end

    def update
      if @member_login.update(member_login_params)
        redirect_to members_url, notice: 'Member login was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @member_login.destroy
      redirect_to member_logins_url, notice: 'Member login was successfully destroyed.'
    end

  private
    def set_member
      @member = Member.find(params[:member_id])
    end

    def set_member_login
      @member_login = MemberLogin.find(params[:id])
    end

    def member_login_params
      params.require(:member_login).permit(:username, :password, :password_confirmation, :active)
    end
  end
end
