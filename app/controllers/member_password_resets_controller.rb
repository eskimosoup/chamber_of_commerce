class MemberPasswordResetsController < ApplicationController
  def new
  end

  def create
    @member = MemberLogin.find_by(username: params[:username])
    if @member
      @member.generate_reset_token
      MemberMailer.password_reset(global_site_settings, @member).deliver_now
      redirect_to new_member_password_reset_url, notice: 'Please check your email'
    else
      flash[:error] = "The given username doesn't exist"
      render :new
    end
  end

  def show
  end
end
