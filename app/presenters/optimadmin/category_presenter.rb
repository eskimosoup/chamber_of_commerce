module Optimadmin
  class CategoryPresenter < BasePresenter
    presents :category

    def id
      category.id
    end

    def title
      category.title
    end

  end
end