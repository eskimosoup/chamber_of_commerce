module Memberships
  class ChargesController < PaymentsController
    def new
      @charge = Stripe::PaymentIntent.create(
        customer: customer.id,
        amount: payment.stripe_price,
        description: "Membership payment ID #{payment.id} (#{payment.company_name})",
        currency: 'gbp'
      )

      @facade = ::Memberships::Charges::NewFacade.new(payment)
    end

    def create
      if payment.update(
        paid: true,
        stripe_payment_intent_id: params[:stripe_payment_intent_id],
        total_paid: payment.total_inc_vat
      )

        MembershipsMailer.new_payment(payment).deliver_now
        MembershipsMailer.new_payment_copy(payment).deliver_now

        redirect_to(
          thank_you_memberships_payments_path,
          notice: 'Thank you for your payment'
        )
      else
        render(:new)
      end
    rescue Stripe::CardError => e
      logger.error("Stripe error while creating customer: #{e.message}")
      @facade = ::Memberships::Charges::NewFacade.new(payment)
      flash[:error] = e.message
      render(:new)
    end

    private

    #
    # Stripe customer
    #
    # @return [object]
    #
    def customer
      Stripe::Customer.create(
        email: payment.accounts_contact_email_address
      )
    end
  end
end
