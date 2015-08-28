class MemberPasswordResetsController < ApplicationController
  def new
  end

  def create
    @member = MemberLogin.find_by(username: params[:username])
    if @member
      @member.generate_reset_token
      if @member.member.email.present?
        MemberMailer.password_reset(global_site_settings, @member).deliver_now
        notice = 'Please check your email for further instructions'
      else
        notice = 'We can not find an email associated with your login. Please contact us via the methods on the contact page to change your password.'
      end
      redirect_to new_member_password_reset_url, notice: notice
    else
      flash[:error] = "The given username doesn't exist"
      render :new
    end
  end

  def update
    @member_login = MemberLogin.find_by(password_reset_token: params[:id])
    if @member_login.update(member_login_params)
      redirect_to login_member_sessions_url, notice: 'Member login was successfully updated.'
    else
      render :show
    end
  end

  def show
    @member_login = MemberLogin.find_by(password_reset_token: params[:id])
    redirect_to new_member_password_reset_url, flash: { error: 'Your password reset token has expired' } if @member_login.updated_at < 2.hours.ago
  end

  private
    def member_login_params
      params.require(:member_login).permit(:password, :password_confirmation)
    end
end
