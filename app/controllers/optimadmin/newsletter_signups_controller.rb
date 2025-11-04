module Optimadmin
  class NewsletterSignupsController < Optimadmin::ApplicationController
    before_action :set_newsletter_signup, only: [:show, :edit, :update, :destroy]

    def index
      @newsletter_signups = Optimadmin::BaseCollectionPresenter.new(collection: NewsletterSignup.where('created_at >= ?', 1.year.ago.beginning_of_day).page(params[:page]).per(params[:per_page] || 15).order(params[:order]), view_template: view_context, presenter: Optimadmin::NewsletterSignupPresenter)
    end

    def export_csv
      @newsletter_signups = NewsletterSignup.all
      send_data @newsletter_signups.to_csv, filename: "newsletter-signups-#{ Date.today }.csv"
    end

    def destroy
      @newsletter_signup.destroy
      redirect_to newsletter_signups_url, notice: 'Newsletter signup was successfully destroyed.'
    end

  private

    def set_newsletter_signup
      @newsletter_signup = NewsletterSignup.find(params[:id])
    end

  end
end
