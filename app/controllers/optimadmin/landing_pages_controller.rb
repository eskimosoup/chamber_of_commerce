module Optimadmin
  class LandingPagesController < Optimadmin::BaseController
    before_action :set_landing_page, only: %i[show edit update destroy]

    edit_images_for ::LandingPage,
                    [
                      [:image, ::LandingPageUploader::CROPS]
                    ]

    def index
      @landing_pages = ::LandingPage.field_order(params[:order] || 'title')
                                    .field_search(params[:search])
                                    .pagination(params[:page], params[:per_page])
    end

    def show; end

    def new
      @landing_page = ::LandingPage.new
    end

    def edit; end

    def create
      @landing_page = ::LandingPage.new(landing_page_params)
      if @landing_page.save
        redirect_to_index_or_continue_editing(@landing_page)
      else
        render(:new)
      end
    end

    def update
      if @landing_page.update(landing_page_params)
        redirect_to_index_or_continue_editing(@landing_page)
      else
        render(:edit)
      end
    end

    def destroy
      if @landing_page.destroy
        redirect_back(fallback_location: { action: :index }, notice: t('optimadmin.controllers.module.destroy', model_name: ::LandingPage.model_name.human))
      else
        redirect_back(fallback_location: { action: :index }, flash: { error: @landing_page.errors.messages[:base].first })
      end
    end

    private

    def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
      redirect_to(fallback_location, notice: (flash.present? ? flash[:error] : notice))
    end

    def set_landing_page
      @landing_page = ::LandingPage.find(params[:id])
    end

    def landing_page_params
      params.require(:landing_page).permit(
        :title,
        :header,
        :content,
        :footer,
        :image,
        :display,
        :style,
        :layout,
        :suggested_url,
        :remove_image,
        :remote_image_url,
        :image_cache,
        :video_embed
      )
    end
  end
end
