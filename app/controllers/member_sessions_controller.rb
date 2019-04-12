class MemberSessionsController < ApplicationController
  include MemberSessionsHelper

  before_action :load_content, except: :destroy
  before_action :members_only, only: :logout

  def login

  end

  def authenticate
    member_login = MemberLogin.find_by(username: member_sessions_params[:username])
    if member_login && member_login.authenticate(member_sessions_params[:password]) && member_login.active.present? && member_login.member.present?
      authenticate_member_session member_login
      remember_member_session member_login if member_sessions_params[:remember_me] == '1'
      return_to = redirect_member_session
      redirect_to return_to, notice: 'Welcome back'
    else
      flash[:error] = 'The username and password are incorrect'
      flash[:error] = 'The password is incorrect' if member_login && member_login.active.present?
      flash[:error] = 'Your account is inactive, please contact us' if member_login && (member_login.active.blank? || member_login.member.blank?)
      render :login
    end
  end

  def logout
    logout_member_session(current_member)
    redirect_to root_url, notice: 'You are now logged out'
  end

  private
    def member_sessions_params
      params.require(:member_sessions).permit(:username, :password, :remember_me)
    end

    def load_content
      @additional_content = AdditionalContentPresenter.new(object: AdditionalContent.find_by(area: 'Members Area - Login'), view_template: view_context)
    end
end
