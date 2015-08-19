module Optimadmin
  class ArticlePresenter < Optimadmin::BasePresenter
    presents :article

    def title
      article.title
    end
  end
end