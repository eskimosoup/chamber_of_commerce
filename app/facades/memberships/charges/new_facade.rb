module Memberships
  module Charges
    class NewFacade < BaseFacade
      include AdditionalContentable

      def initialize(payment)
        @payment = payment
      end

      attr_reader :payment
    end
  end
end
