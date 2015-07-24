class MemberArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def index
    @presented_articles = BaseCollectionPresenter.new(collection: Article.member_article.published.order(date: :desc).page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: ArticlePresenter)
    render template: 'articles/index'
  end

  def show
    if member_article_path(@presented_article) != request.path
      redirect_to @presented_article, status: :moved_permanently
    end
    render template: 'articles/show'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @presented_article = ArticlePresenter.new(object: Article.member_article.published.friendly.find(params[:id]), view_template: view_context)
    end

end
