module Optimadmin
  class ArticlePresenter < Optimadmin::BasePresenter
    presents :article

    def title
      article.title
    end

    def date
      h.l article.date, format: :long
    end

    def summary
      h.simple_format article.summary
    end

    def toggle_title
      inline_detail_toggle_link(title)
    end

    def edit_image(image)
      return unless article.send(image).thumb.present?
      h.link_to(h.image_tag(article.send(image).thumb.url), { action: :edit_images, id: article, controller: "/optimadmin/#{article.class.name.to_s.tableize}" })
    end
  end
end
