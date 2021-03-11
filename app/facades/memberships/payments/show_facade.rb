module Memberships
  module Payments
    class ShowFacade < BaseFacade
      include AdditionalContentable

      def initialize(payment)
        @payment = payment
      end

      attr_reader :payment
    end
  end
end
