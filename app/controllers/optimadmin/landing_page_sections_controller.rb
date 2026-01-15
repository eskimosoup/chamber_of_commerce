module Optimadmin
  class LandingPageSectionsController < Optimadmin::BaseController
    before_action :set_landing_page
    before_action :set_landing_page_section, only: %i[show edit update destroy]

    edit_images_for ::LandingPageSection,
                    [
                      [:image, ::LandingPageSectionUploader::CROPS]
                    ]

    def index
      @landing_page_sections = @landing_page.landing_page_sections
    end

    def show; end

    def new
      @landing_page_section = @landing_page.landing_page_sections.new
    end

    def edit; end

    def create
      @landing_page_section = @landing_page.landing_page_sections.new(landing_page_section_params)
      if @landing_page_section.save
        redirect_to_index_or_continue_editing(@landing_page_section)
      else
        render(:new)
      end
    end

    def update
      if @landing_page_section.update(landing_page_section_params)
        redirect_to_index_or_continue_editing(@landing_page_section)
      else
        render(:edit)
      end
    end

    def destroy
      if @landing_page_section.destroy
        redirect_back(fallback_location: { action: :index }, notice: t('optimadmin.controllers.module.destroy', model_name: ::LandingPageSection.model_name.human))
      else
        redirect_back(fallback_location: { action: :index }, flash: { error: @landing_page_section.errors.messages[:base].first })
      end
    end

    private

    def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
      redirect_to(fallback_location, notice: (flash.present? ? flash[:error] : notice))
    end

    def set_landing_page
      @landing_page = ::LandingPage.find(params[:landing_page_id])
    end

    def set_landing_page_section
      @landing_page_section = @landing_page.landing_page_sections.find(params[:id])
    end

    def landing_page_section_params
      params.require(:landing_page_section).permit(
        :landing_page_id,
        :position,
        :area,
        :title,
        :content,
        :image,
        :button_link,
        :button_text,
        :display,
        :remove_image,
        :remote_image_url,
        :image_cache
      )
    end
  end
end
