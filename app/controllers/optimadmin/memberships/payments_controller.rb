module Optimadmin
  class Memberships::PaymentsController < Optimadmin::BaseController
    before_action :set_payment, only: %i[show edit update destroy]

    def index
      @payments = ::Memberships::Payment.field_order('created_at desc')
                                        .field_search(params[:search], 'company_name')
                                        .pagination(params[:page], params[:per_page])
    end

    def show; end

    private

    def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
      redirect_to(fallback_location, notice: (flash.present? ? flash[:error] : notice))
    end

    def set_payment
      @payment = ::Memberships::Payment.find_by(hashed_id: params[:id])
    end
  end
end
