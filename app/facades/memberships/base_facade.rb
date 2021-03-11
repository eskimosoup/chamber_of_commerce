module Memberships
  class BaseFacade
    def packages
      @packages = ::Memberships::Package.displayed.ordered
    end

    def packages?
      packages.present?
    end
  end
end
