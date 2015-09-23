class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :set_article_categories, only: [:index]

  def index
    @presented_articles = BaseCollectionPresenter.new(collection: Article.published.order(date: :desc).page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: ArticlePresenter)
  end

  def show
    redirect_to @article, status: :moved_permanently if article_path(@article) != request.path
    @presented_articles = BaseCollectionPresenter.new(collection: @article.article_category.articles.published.limit(5), view_template: view_context, presenter: ArticlePresenter)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.published.admin(current_administrator).friendly.find(params[:id])
      @presented_article = ArticlePresenter.new(object: @article, view_template: view_context)
    end

    def set_article_categories
      @presented_article_categories = BaseCollectionPresenter.new(collection: ArticleCategory.order(title: :asc), view_template: view_context, presenter: ArticleCategoryPresenter)
    end

end
