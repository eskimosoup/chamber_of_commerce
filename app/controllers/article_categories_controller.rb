class ArticleCategoriesController < ApplicationController

  before_action :set_article_categories

  def show
    @presented_article_category = ArticleCategoryPresenter.new(object: ArticleCategory.friendly.find(params[:id]), view_template: view_context)
    if request.path != article_category_path(@presented_article_category)
      redirect_to article_category_url(@presented_article_category), status: :moved_permanently
    else
      @presented_articles = BaseCollectionPresenter.new(collection: @presented_article_category.articles.published.order(date: :desc).page(params[:page]).per(params[:per_page] || 15), view_template: view_context, presenter: ArticlePresenter)
      render template: 'articles/index'
    end
  end

  private

  def set_article_categories
    @presented_article_categories = BaseCollectionPresenter.new(collection: ArticleCategory.order(title: :asc), view_template: view_context, presenter: ArticleCategoryPresenter)
  end
end
