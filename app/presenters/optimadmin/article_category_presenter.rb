module Optimadmin
  class ArticleCategoryPresenter < Optimadmin::BasePresenter
    presents :article_category

    def title
      article_category.title
    end

  end
end
