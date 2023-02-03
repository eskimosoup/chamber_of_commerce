module Optimadmin
  module Memberships
    class PackagePresenter
      include Optimadmin::PresenterMethods

      presents :package
      delegate :id, :title, :special_offer_price?, to: :package

      def cost
        h.number_to_currency(package.cost)
      end

      def special_offer_price
        h.number_to_currency(package.special_offer_price)
      end

      def price
        h.number_to_currency(package.price)
      end
    end
  end
end
