module Optimadmin
  module Memberships
    class JoinReasonsController < Optimadmin::BaseController
      before_action :set_join_reason, only: %i[show edit update destroy]

      def index
        @join_reasons = ::Memberships::JoinReason.field_order(params[:order] || 'position')
                                                 .field_search(params[:search])
                                                 .pagination(params[:page], params[:per_page])
      end

      def show; end

      def new
        @join_reason = ::Memberships::JoinReason.new
      end

      def edit; end

      def create
        @join_reason = ::Memberships::JoinReason.new(memberships_join_reason_params)
        if @join_reason.save
          redirect_to_index_or_continue_editing(@join_reason)
        else
          render(:new)
        end
      end

      def update
        if @join_reason.update(memberships_join_reason_params)
          redirect_to_index_or_continue_editing(@join_reason)
        else
          render(:edit)
        end
      end

      def destroy
        if @join_reason.destroy
          redirect_back(
            fallback_location: { action: :index },
            notice: t(
              'optimadmin.controllers.module.destroy',
              model_name: ::Memberships::JoinReason.model_name.human
            )
          )
        else
          redirect_back(
            fallback_location: { action: :index },
            flash: { error: @join_reason.errors.messages[:base].first }
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

      def set_join_reason
        @join_reason = ::Memberships::JoinReason.find(params[:id])
      end

      def memberships_join_reason_params
        params.require(:memberships_join_reason).permit(
          :position,
          :title,
          :display
        )
      end
    end
  end
end
