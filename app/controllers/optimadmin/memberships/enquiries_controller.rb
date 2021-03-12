module Optimadmin
  module Memberships
    class EnquiriesController < Optimadmin::BaseController
      before_action :set_enquiry, only: %i[show edit update destroy]

      def index
        @enquiries = ::Memberships::Enquiry.field_order(params[:order] || 'created_at desc')
                                           .field_search(params[:search], 'company_name')
                                           .pagination(params[:page], params[:per_page])
      end

      def show; end

      private

      def set_enquiry
        @enquiry = ::Memberships::Enquiry.find(params[:id])
      end
    end
  end
end
