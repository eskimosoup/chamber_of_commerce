module Optimadmin
  class AdditionalContentsController < Optimadmin::ApplicationController
    before_action :set_additional_content, only: [:show, :edit, :update, :destroy]

    def index
      @additional_contents = Optimadmin::BaseCollectionPresenter.new(collection: AdditionalContent.where('title ILIKE ?', "#{params[:search]}%").page(params[:page]).per(params[:per_page] || 15).order(params[:order]), view_template: view_context, presenter: Optimadmin::AdditionalContentPresenter)
    end

    def show
    end

    def new
      @additional_content = AdditionalContent.new
    end

    def edit
    end

    def create
      @additional_content = AdditionalContent.new(additional_content_params)
      if @additional_content.save
        redirect_to additional_contents_url, notice: 'Additional content was successfully created.'
      else
        render :new
      end
    end

    def update
      if @additional_content.update(additional_content_params)
        redirect_to additional_contents_url, notice: 'Additional content was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @additional_content.destroy
      redirect_to additional_contents_url, notice: 'Additional content was successfully destroyed.'
    end

  private


    def set_additional_content
      @additional_content = AdditionalContent.find(params[:id])
    end

    def additional_content_params
      params.require(:additional_content).permit(:area, :title, :content)
    end
  end
end
