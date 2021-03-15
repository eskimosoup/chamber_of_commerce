module Optimadmin
  module Memberships
    class PaymentsController < Optimadmin::BaseController
      before_action :set_payment, only: %i[show edit update destroy]

      def index
        @payments = ::Memberships::Payment.field_order('created_at desc')
                                          .field_search(params[:search], 'company_name')
                                          .pagination(params[:page], params[:per_page])

        respond_to do |format|
          format.html
          format.csv { csv_data }
        end
      end

      def show; end

      private

      def csv_data
        send_data(
          csv,
          type: 'text/csv; charset=iso-8859-1; header=present',
          disposition: 'attachment',
          filename: 'membership-payments.csv'
        )
      end

      def csv
        ::CsvExports::MembershipPaymentsService.new(::Memberships::Payment.all, 'index').to_csv
      end

      def redirect_back(fallback_location: { action: :index }, flash: nil, notice: nil)
        redirect_to(
          fallback_location,
          notice: (flash.present? ? flash[:error] : notice)
        )
      end

      def set_payment
        @payment = ::Memberships::Payment.find_by(hashed_id: params[:id])
      end
    end
  end
end
