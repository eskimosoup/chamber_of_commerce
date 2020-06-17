class MemberPasswordResetsController < ApplicationController
  def new
  end

  def create
    @member = member
    if @member
      @member.member_login.map(&:generate_reset_token)
      MemberMailer.password_reset(global_site_settings, @member).deliver_now
      notice = 'Please check your email for further instructions'
      redirect_to new_member_password_reset_url, notice: notice
    else
      flash[:error] = "Member email address doesn't exist"
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
  rescue NoMethodError
    redirect_to new_member_password_reset_url, flash: { error: 'Your password reset token has expired' }
  end

  private
    def member
      Member.find_by(email: params[:email_address])
    end

    def member_login_params
      params.require(:member_login).permit(:password, :password_confirmation)
    end
end
