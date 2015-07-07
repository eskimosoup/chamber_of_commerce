class ArticlePresenter < BasePresenter
  presents :article

  def id
    article.id
  end

  def class_name
    article.class.name.downcase
  end

  def title
    article.title
  end

  def linked_title(options = {})
    h.link_to article.title, article, options
  end

  def date(format = :long)
    h.l article.date, format: format
  end

  def summary
    h.raw article.summary
  end

  def content
    h.raw article.content
  end

  def image
    h.image_tag article.image.show, alt: article.title, class: 'page-image image-right' if article.image?
  end

  def linked_home_image
    h.link_to article, title: article.title do
      if article.image?
        h.image_tag article.image.homepage, alt: article.title
      else
        h.image_tag 'placeholders/home-slider.jpg', alt: article.title
      end
    end
  end
end
