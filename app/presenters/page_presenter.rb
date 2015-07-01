class PagePresenter < BasePresenter
  presents :page

  def title
    h.content_tag :h1 do
      page.title
    end
  end

  def content
    h.raw page.content
  end

  def image
    h.image_tag page.image.show, alt: page.title, class: 'page-image image-right' if page.image?
  end
end
