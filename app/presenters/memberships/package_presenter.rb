module Memberships
  class PackagePresenter < BasePresenter
    presents :package
    delegate :title, :special_offer_price?, to: :package

    def cost
      h.number_to_currency(package.cost).gsub('.00', '')
    end

    def special_offer_price
      h.number_to_currency(package.special_offer_price).gsub('.00', '')
    end

    def price
      h.number_to_currency(package.price).gsub('.00', '')
    end
  end
end
