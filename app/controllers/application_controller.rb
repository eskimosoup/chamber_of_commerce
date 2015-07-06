class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :global_site_settings, :load_objects

  def index
    @magazine = MagazinePresenter.new(object: Magazine.where("date <= ? AND display = ?", Date.today, true).order(date: :desc).first, view_template: view_context)
  end

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings

  def load_objects
    @presented_articles = BaseCollectionPresenter.new(collection: Article.published, view_template: view_context, presenter: ArticlePresenter)
    @presented_events   = BaseCollectionPresenter.new(collection: Event.upcoming.bookable, view_template: view_context, presenter: EventPresenter)
    # TODO: Add members offers here
    #@presented_members_offers   = BaseCollectionPresenter.new(collection:, view_template: view_context, presenter: MemberOfferPresenter)

    @patrons = BaseCollectionPresenter.new(collection: Patron.where(display: true).order(position: :asc), view_template: view_context, presenter: PatronPresenter)
    #@internal_promotions = InternalPromotionPresenter.new(object: InternalPromotion.where(display: true).order(created_at: :desc), view_template: view_context)
    @header_menu = Optimadmin::Menu.new(name: "header")
    @footer_menu = Optimadmin::Menu.new(name: "footer")
    @newsletter_signup = NewsletterSignup.new
  end
end
