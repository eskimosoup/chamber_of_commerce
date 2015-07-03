module Optimadmin
  class ArticleCategoryPresenter < Optimadmin::BasePresenter
    presents :article_category

    def id
      article_category.id
    end

    def title
      article_category.title
    end

  end
end
