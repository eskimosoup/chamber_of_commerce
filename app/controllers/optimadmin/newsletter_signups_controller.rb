module Optimadmin
  class NewsletterSignupsController < Optimadmin::ApplicationController
    before_action :set_newsletter_signup, only: [:show, :edit, :update, :destroy]

    def index
      @newsletter_signups = Optimadmin::BaseCollectionPresenter.new(collection: NewsletterSignup.page(params[:page]).per(params[:per_page] || 15).order(params[:order]), view_template: view_context, presenter: Optimadmin::NewsletterSignupPresenter)
    end

    def export_csv
      @newsletter_signups = NewsletterSignup.all
      send_data @newsletter_signups.to_csv, filename: "newsletter-signups-#{ Date.today }.csv"
    end

    def show
    end

    def new
      @newsletter_signup = NewsletterSignup.new
    end

    def edit
    end

    def create
      @newsletter_signup = NewsletterSignup.new(newsletter_signup_params)
      if @newsletter_signup.save
        redirect_to newsletter_signups_url, notice: 'Newsletter signup was successfully created.'
      else
        render :new
      end
    end

    def update
      if @newsletter_signup.update(newsletter_signup_params)
        redirect_to newsletter_signups_url, notice: 'Newsletter signup was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @newsletter_signup.destroy
      redirect_to newsletter_signups_url, notice: 'Newsletter signup was successfully destroyed.'
    end

  private


    def set_newsletter_signup
      @newsletter_signup = NewsletterSignup.find(params[:id])
    end

    def newsletter_signup_params
      params.require(:newsletter_signup).permit(:email_address)
    end
  end
end
