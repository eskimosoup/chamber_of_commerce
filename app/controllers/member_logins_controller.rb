class MemberLoginsController < ApplicationController
  before_action :load_content
  before_action :members_only, only: [:edit, :update]

  def new
    @member_login = MemberLogin.new
  end

  def create
    @member_login = MemberLogin.new(member_login_params)
    if @member_login.save
      MemberMailer.new_member_login(global_site_settings, @member_login).deliver_now
      redirect_to login_member_sessions_path, notice: 'Member login was successfully created.'
    else
      render :new
    end
  end

  def edit
    @member_login = current_member.member_login
  end

  def update
    @member_login = current_member.member_login
    if @member_login.update(member_login_params)
      redirect_to edit_member_logins_url, notice: 'Member login was successfully updated.'
    else
      render :edit
    end
  end

  private
    def member_login_params
      params.require(:member_login).permit(:member_id, :username, :password, :password_confirmation)
    end

    def load_content
      @additional_content = AdditionalContentPresenter.new(object: AdditionalContent.find_by(area: 'Members Area - Sign Up'), view_template: view_context)
    end
end