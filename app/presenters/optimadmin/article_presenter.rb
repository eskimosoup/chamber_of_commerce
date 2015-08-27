module Optimadmin
  class ArticlePresenter < Optimadmin::BasePresenter
    presents :article

    def title
      article.title
    end

    def summary
      h.raw article.summary
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end
  end
end
