module Optimadmin
  class InternalPromotionPresenter < BasePresenter
    presents :internal_promotion

    def id
      internal_promotion.id
    end

    def name
      internal_promotion.name
    end

    def area
      internal_promotion.area
    end

  end
end
