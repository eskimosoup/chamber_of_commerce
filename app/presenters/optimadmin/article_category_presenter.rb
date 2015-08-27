module Optimadmin
  class ArticleCategoryPresenter < Optimadmin::BasePresenter
    presents :article_category

    def title
      article_category.title
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

  end
end
