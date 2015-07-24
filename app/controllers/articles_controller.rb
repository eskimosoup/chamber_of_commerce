class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :set_article_categories, only: [:index]

  def index
    @presented_articles = BaseCollectionPresenter.new(collection: Article.non_member_news.published.order(date: :desc).page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: ArticlePresenter)
  end

  def show
    if article_path(@presented_article) != request.path
      redirect_to @presented_article, status: :moved_permanently
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @presented_article = ArticlePresenter.new(object: Article.published.friendly.find(params[:id]), view_template: view_context)
    end

    def set_article_categories
      @presented_article_categories = BaseCollectionPresenter.new(collection: ArticleCategory.order(title: :asc), view_template: view_context, presenter: ArticleCategoryPresenter)
    end

end
