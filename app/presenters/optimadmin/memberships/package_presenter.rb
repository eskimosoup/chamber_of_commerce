module Optimadmin
  module Memberships
    class PackagePresenter
      include Optimadmin::PresenterMethods

      presents :package
      delegate :id, :title, to: :package

      def cost
        h.number_to_currency(package.cost)
      end
    end
  end
end
