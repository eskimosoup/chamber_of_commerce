class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include MemberSessionsHelper
  include Optimadmin::AdminSessionsHelper
  include Optimadmin::ErrorReporting
  include LocationAdvertisements

  helper_method :current_administrator

  before_action :global_site_settings, :load_objects, :current_member
  before_action :aside_content

=begin
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: ->(e) { render_error(500, e) }
    rescue_from ActiveRecord::RecordNotFound, with: ->(e) { render_error(404, e) }
    rescue_from ActionController::RoutingError, with: ->(e) { render_error(404, e) }
  end

  def render_error(status, error)
    logger.error "#{error.class}: #{error.message}"
    respond_to do |format|
      format.html { render "errors/#{status}", status: status }
      format.all { render nothing: true, status: status }
    end
  end
=end

  def index
    @presented_articles       = BaseCollectionPresenter.new(collection: Article.published.order(date: :desc).limit(10), view_template: view_context, presenter: ArticlePresenter)
    @presented_member_news    = BaseCollectionPresenter.new(collection: Article.member_news.limit(5), view_template: view_context, presenter: ArticlePresenter)
    @presented_events         = BaseCollectionPresenter.new(collection: Event.upcoming.limit(10), view_template: view_context, presenter: EventPresenter)
    @presented_members_offers = BaseCollectionPresenter.new(collection: MemberOffer.includes(:member).current.verified, view_template: view_context, presenter: MemberOfferPresenter)
    @page_types = Page.where(page_type: %w(members_services international_trade patrons policy_and_representation), display: true).group_by(&:page_type)
    @member_news = ArticleCategory.find_by(member_related: true)
    @internal_promotions = InternalPromotionPresenter.new(object: InternalPromotion.where(display: true).order(created_at: :desc), view_template: view_context)
    @magazine = MagazinePresenter.new(object: Magazine.where('date <= ? AND display = ?', Date.today, true).order(date: :desc).first, view_template: view_context)
    @members_services_menu = Optimadmin::Menu.new(name: 'members_services')
  end

  helper_method def membership_banner
  @membership_banner ||= AdditionalContent.find_by(area: 'Membership Banner')
  end

  helper_method def app_banner
    @app_banner ||= AdditionalContent.find_by(area: 'App Banner')
  end

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings

  def aside_content
    @presented_articles       = BaseCollectionPresenter.new(collection: Article.non_member_news.limit(3), view_template: view_context, presenter: ArticlePresenter)
    @presented_member_news    = BaseCollectionPresenter.new(collection: Article.member_news.limit(3), view_template: view_context, presenter: ArticlePresenter)
    @presented_events         = BaseCollectionPresenter.new(collection: Event.upcoming.limit(3), view_template: view_context, presenter: EventPresenter)
    @presented_members_offers = BaseCollectionPresenter.new(collection: MemberOffer.includes(:member).current.verified.limit(5), view_template: view_context, presenter: MemberOfferPresenter)
  end

  def load_objects
    @patrons = BaseCollectionPresenter.new(collection: Patron.display, view_template: view_context, presenter: PatronPresenter)
    @header_menu = Optimadmin::Menu.new(name: 'header')
    @footer_menu = Optimadmin::Menu.new(name: 'footer')
    @newsletter_signup = NewsletterSignup.new
    @chamber_event_group = EventGroup.displayed.find_by(area: 'Chamber')
    @chamber_events = ::Event.upcoming.where('id IN (?) OR event_agendas_count = ?', @chamber_event_group.events.upcoming.ids, 0) if @chamber_event_group.present?
    advertisements
  end

  def current_member
    current_member_login.member if current_member_login.present?
  end
  helper_method :current_member

  def current_member_login
    auth_token_current_member = MemberLogin.find_by(auth_token: cookies[:member_auth_token]) if cookies.signed[:member_id]
    authenticate_member_session(auth_token_current_member) if auth_token_current_member
    MemberLogin.find(session[:member_id]) if session[:member_id]
  rescue ActiveRecord::RecordNotFound
    cookies.delete(:member_id) if cookies.permanent.signed[:member_id]
    cookies.delete(:member_auth_token) if cookies.permanent[:member_auth_token]
    session[:member_id] = nil
  end
  helper_method :current_member_login

  def members_only
    return if current_member
    session[:return_to] = request.fullpath unless blacklist_redirect_member_session.include?(request.fullpath)
    redirect_to login_member_sessions_url, flash: { error: 'You must be logged into to view this page.' }
  end
end
