module Optimadmin
  class Memberships::HowHeardsController < Optimadmin::BaseController
    before_action :set_how_heard, only: %i[show edit update destroy]

    def index
      @how_heards = ::Memberships::HowHeard.field_order(params[:order] || 'position')
                                           .field_search(params[:search])
                                           .pagination(params[:page], params[:per_page])
    end

    def show; end

    def new
      @how_heard = ::Memberships::HowHeard.new
    end

    def edit; end

    def create
      @how_heard = ::Memberships::HowHeard.new(memberships_how_heard_params)
      if @how_heard.save
        redirect_to_index_or_continue_editing(@how_heard)
      else
        render(:new)
      end
    end

    def update
      if @how_heard.update(memberships_how_heard_params)
        redirect_to_index_or_continue_editing(@how_heard)
      else
        render(:edit)
      end
    end

    def destroy
      if @how_heard.destroy
        redirect_back(fallback_location: { action: :index }, notice: t('optimadmin.controllers.module.destroy', model_name: ::Memberships::HowHeard.model_name.human))
      else
        redirect_back(fallback_location: { action: :index }, flash: { error: @how_heard.errors.messages[:base].first })
      end
    end

    private

    def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
      redirect_to(fallback_location, notice: (flash.present? ? flash[:error] : notice))
    end

    def set_how_heard
      @how_heard = ::Memberships::HowHeard.find(params[:id])
    end

    def memberships_how_heard_params
      params.require(:memberships_how_heard).permit(
        :position,
        :title,
        :display
      )
    end
  end
end
