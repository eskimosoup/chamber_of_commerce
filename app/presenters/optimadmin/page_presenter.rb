module Optimadmin
  class PagePresenter < BasePresenter
    presents :page

    def id
      page.id
    end

    def title
      page.title
    end

    def content
      h.raw page.content
    end
  end
end
