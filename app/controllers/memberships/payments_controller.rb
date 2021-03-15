module Memberships
  class PaymentsController < BaseController
    before_action :require_payment, except: [:create]

    def create
      @payment = ::Memberships::Payment.new(memberships_payment_params)
      if @payment.save
        session[:payment] = @payment.hashed_id
        redirect_to(edit_memberships_payment_path(@payment))
      else
        @facade = ::Memberships::Homes::IndexFacade.new
        @enquiry = ::Memberships::Enquiry.new
        render('memberships/homes/index')
      end
    end

    def edit
      @facade = ::Memberships::Payments::EditFacade.new
      @payment = payment
    end

    def update
      @payment = payment
      if @payment.update(memberships_payment_params)
        redirect_to(new_memberships_payment_charge_path(@payment))
      else
        @facade = ::Memberships::Payments::EditFacade.new
        render(:edit)
      end
    end

    def show
      return redirect_to(new_memberships_payment_charge_path(payment)) unless payment.paid?

      @facade = ::Memberships::Payments::ShowFacade.new(payment)
      session[:payment] = nil
      session.delete(:payment)
    end

    private

    def require_payment
      redirect_to(memberships_root_path) if payment.blank?
    end

    def payment
      return false if session[:payment].blank?

      ::Memberships::Payment.find_by(hashed_id: session[:payment])
    end

    def memberships_payment_params
      params.require(:memberships_payment).permit(
        :company_name,
        :address_line_1,
        :address_line_2,
        :city,
        :county,
        :postcode,
        :business_activity,
        :number_of_employees,
        :website,
        :telephone,
        :legal_status,
        :business_start_date,
        :linkedin,
        :twitter,
        :facebook,
        :instagram,
        :primary_contact_title,
        :primary_contact_forename,
        :primary_contact_surname,
        :primary_contact_role,
        :primary_contact_telephone,
        :primary_contact_email_address,
        :company_number,
        :vat_number,
        :accounts_contact_title,
        :accounts_contact_forename,
        :accounts_contact_surname,
        :accounts_contact_role,
        :accounts_contact_telephone,
        :accounts_contact_email_address,
        :postcode,
        :memberships_package_id,
        how_heard_ids: [],
        join_reason_ids: [],
      )
    end
  end
end
