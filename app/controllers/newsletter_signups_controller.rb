class NewsletterSignupsController < ApplicationController
  def new
    @newsletter_signup = NewsletterSignup.new
  end

  def create
    @newsletter_signup = NewsletterSignup.new(newsletter_signup_params)

    respond_to do |format|
      if @newsletter_signup.save
        format.html { render :create }
        format.js { render :create }
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  private

    def newsletter_signup_params
      params.require(:newsletter_signup).permit(:email_address)
    end
end
