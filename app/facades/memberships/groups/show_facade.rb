module Memberships
  module Groups
    class ShowFacade
      def initialize(group)
        @group = group
      end

      def side_menus
        @side_menus ||= group.side_menus
      end

      def side_menus?
        side_menus.present?
      end

      attr_reader :group
    end
  end
end
