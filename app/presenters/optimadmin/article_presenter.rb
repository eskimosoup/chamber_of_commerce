module Optimadmin
  class ArticlePresenter < Optimadmin::BasePresenter
    presents :article

    def id
      article.id
    end

    def title
      article.title
    end
  end
end