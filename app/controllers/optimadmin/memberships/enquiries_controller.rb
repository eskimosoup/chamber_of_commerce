module Optimadmin
  module Memberships
    class EnquiriesController < Optimadmin::BaseController
      before_action :set_enquiry, only: %i[show edit update destroy]

      def index
        @enquiries = ::Memberships::Enquiry.field_order(params[:order] || 'created_at desc')
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
          filename: 'membership-enquiries.csv'
        )
      end

      def csv
        ::CsvExports::MembershipEnquiriesService.new(::Memberships::Enquiry.all, 'index').to_csv
      end

      def set_enquiry
        @enquiry = ::Memberships::Enquiry.find(params[:id])
      end
    end
  end
end
