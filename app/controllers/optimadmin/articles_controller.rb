# frozen_string_literal: true

module Optimadmin
  class ArticlesController < Optimadmin::ApplicationController
    before_action :set_article, only: %i[show edit update destroy]
    before_action :display_status, only: :index

    edit_images_for Article,
                    [
                      [:image, {
                        # index: ['fill', 250, 250],
                        # show: ['fill', 215, 135]
                        show_full_image: ['fit', 613, 9999],
                        homepage: ['fill', 450, 295]
                      }]
                    ]

    def index
      @articles = @all_items
                  .pagination(params[:page], params[:per_page])
    end

    def show; end

    def new
      @article = Article.new
    end

    def edit; end

    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to_index_or_continue_editing(@article)
      else
        render :new
      end
    end

    def update
      if @article.update(article_params)
        redirect_to_index_or_continue_editing(@article)
      else
        render :edit
      end
    end

    def destroy
      @article.destroy
      if @article.errors.present?
        redirect_back(fallback_location: { action: :index }, flash: { error: @article.errors.messages[:base].first })
      else
        redirect_back(fallback_location: { action: :index }, notice: t('optimadmin.controllers.module.destroy', model_name: Article.model_name.human))
      end
    end

    private

    def display_status
      @all_items = Article.order(date: :desc)
                          .field_search(params[:search])
      @scheduled_items = @all_items.scheduled.pluck(:id)
      @published_items = @all_items.published.pluck(:id)
      @expired_items   = @all_items.expired.pluck(:id)
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(
        :title, :article_category_id, :summary, :content, :image, :date,
        :suggested_url, :layout, :caption, :display,
        :remove_image, :remote_image_url, :image_cache
      )
    end
  end
end
