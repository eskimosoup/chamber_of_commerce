module Optimadmin
  class Memberships::PaymentPresenter
    include Optimadmin::PresenterMethods

    presents :payment
    delegate :id, :title, :company_name, to: :payment

    def submitted
      h.l(payment.created_at, format: :long)
    end

    def view_link
      h.link_to(eye, payment)
    end

    def paid
      payment.paid? ? 'Yes' : 'No'
    end
  end
end
