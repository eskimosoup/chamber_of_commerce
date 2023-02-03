module Optimadmin
  module Memberships
    class PackagesController < ::Optimadmin::BaseController
      before_action :set_package, only: %i[show edit update destroy]

      def index
        @packages = ::Memberships::Package.field_order(params[:order] || 'position')
                                          .field_search(params[:search])
                                          .pagination(params[:page], params[:per_page])
      end

      def show; end

      def new
        @package = ::Memberships::Package.new
      end

      def edit; end

      def create
        @package = ::Memberships::Package.new(memberships_package_params)
        if @package.save
          redirect_to_index_or_continue_editing(@package)
        else
          render(:new)
        end
      end

      def update
        if @package.update(memberships_package_params)
          redirect_to_index_or_continue_editing(@package)
        else
          render(:edit)
        end
      end

      def destroy
        if @package.destroy
          redirect_back(
            fallback_location: { action: :index },
            notice: t(
              'optimadmin.controllers.module.destroy',
              model_name: ::Memberships::Package.model_name.human
            )
          )
        else
          redirect_back(
            fallback_location: { action: :index },
            flash: { error: @package.errors.messages[:base].first }
          )
        end
      end

      private

      def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
        redirect_to(
          fallback_location,
          notice: (flash.present? ? flash[:error] : notice)
        )
      end

      def set_package
        @package = ::Memberships::Package.find(params[:id])
      end

      def memberships_package_params
        params.require(:memberships_package).permit(
          :position,
          :title,
          :cost,
          :display,
          :special_offer_price
        )
      end
    end
  end
end
