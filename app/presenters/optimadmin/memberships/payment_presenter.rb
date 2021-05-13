# frozen_string_literal: true

module Optimadmin
  module Memberships
    class PaymentPresenter
      include Optimadmin::PresenterMethods

      presents :payment
      delegate :id, :title, :company_name, to: :payment

      def submitted
        h.l(payment.created_at, format: :long)
      end

      def manage
        h.link_to(
          'Create member login',
          h.memberships_payment_path(payment, anchor: 'member-login')
        )
      end

      def view_link
        h.link_to(eye, payment)
      end

      def paid
        payment.paid? ? 'Yes' : 'No'
      end
    end
  end
end
