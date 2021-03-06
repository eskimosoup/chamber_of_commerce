module Memberships
  class PackagePresenter < BasePresenter
    presents :package
    delegate :title, to: :package

    def cost
      h.number_to_currency(package.cost).gsub('.00', '')
    end
  end
end
