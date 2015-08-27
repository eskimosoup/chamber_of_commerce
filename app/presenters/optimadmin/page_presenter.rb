module Optimadmin
  class PagePresenter < Optimadmin::BasePresenter
    presents :page

    def title
      page.title
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def content
      h.raw page.content
    end
  end
end
