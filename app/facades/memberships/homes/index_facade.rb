module Memberships
  module Homes
    class IndexFacade < BaseFacade
      include AdditionalContentable

      def groups
        @groups = ::Memberships::Group.displayed.ordered
      end

      def groups?
        groups.present?
      end
    end
  end
end
