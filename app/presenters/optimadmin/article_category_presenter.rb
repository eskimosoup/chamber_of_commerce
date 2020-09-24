module Optimadmin
  class ArticleCategoryPresenter < Optimadmin::BasePresenter
    presents :article_category

    def title
      article_category.title
    end

    def toggle_title
      title
    end

  end
end
