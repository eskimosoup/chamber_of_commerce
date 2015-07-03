class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def index
    @presented_articles = BaseCollectionPresenter.new(collection: Article.where(display: true).where("date <= ?", Date.today), view_template: view_context, presenter: ArticlePresenter)
  end

  def show
    raise article_path(Article.friendly.find(params[:id])).to_yaml
    raise article_path(@article).to_yaml
    if article_path(@article) != request.path
      redirect_to @article, status: :moved_permanently
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = ArticlePresenter.new(object: Article.friendly.find(params[:id]), view_template: view_context)
    end

end
