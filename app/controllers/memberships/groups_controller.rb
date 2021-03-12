module Memberships
  class GroupsController < BaseController
    def show
      redirect_to_slug(group)

      @facade = ::Memberships::Groups::ShowFacade.new(group)
    end

    private

    def group
      ::Memberships::Group.displayed.find(params[:id])
    end
  end
end
