module Memberships
  class EnquiriesController < BaseController
    def create
      @enquiry = ::Memberships::Enquiry.new(memberships_enquiry_params)
      if @enquiry.save
        MembershipsMailer.new_enquiry(@enquiry).deliver_now
        redirect_to(memberships_root_path, notice: 'Thank you for your enquiry. We will be in touch.')
      else
        @facade = ::Memberships::Homes::IndexFacade.new
        @payment = ::Memberships::Payment.new
        render('memberships/homes/index')
      end
    end

    private

    def memberships_enquiry_params
      params.require(:memberships_enquiry).permit(
        :forename,
        :surname,
        :telephone,
        :email_address,
        :company_name,
        :postcode,
        :memberships_package_id,
        :message
      )
    end
  end
end
