module Optimadmin
  class ArticleCategoriesController < Optimadmin::ApplicationController
    before_action :set_article_category, only: [:show, :edit, :update, :destroy]

    def index
      @article_categories = Optimadmin::BaseCollectionPresenter.new(collection: ArticleCategory.where('title ILIKE ?', "#{params[:search]}%").order(:title), view_template: view_context, presenter: Optimadmin::ArticleCategoryPresenter)
    end

    def show
    end

    def new
      @article_category = ArticleCategory.new
    end

    def edit
    end

    def create
      @article_category = ArticleCategory.new(article_category_params)
      if @article_category.save
        redirect_to article_categories_url, notice: 'Article category was successfully created.'
      else
        render :new
      end
    end

    def update
      if @article_category.update(article_category_params)
        redirect_to article_categories_url, notice: 'Article category was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @article_category.destroy
      redirect_to article_categories_url, notice: 'Article category was successfully destroyed.'
    end

  private


    def set_article_category
      @article_category = ArticleCategory.friendly.find(params[:id])
    end

    def article_category_params
      params.require(:article_category).permit(:title, :member_related)
    end
  end
end
