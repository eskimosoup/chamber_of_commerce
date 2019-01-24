# frozen_string_literal: true

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

  def linked_truncated_title(options = {}, truncate_length = 136)
    h.link_to h.truncate(article.title, length: truncate_length), article, options
  end

  def date(format = :long)
    h.content_tag :span, class: 'date' do
      h.l article.date.to_date, format: format
    end
  end

  def linked_category
    h.link_to article.article_category, title: article.article_category.title do
      h.content_tag :span, class: 'article-category' do
        article.article_category.title
      end
    end
  end

  def summary
    h.simple_format article.summary
  end

  def content
    h.raw article.content
  end

  def image
    return nil if article.image.blank? || article.layout == 'no_image'
    h.content_tag :div, (image_from_layout + image_caption), class: ('image-right image-right--width' if article.layout == 'right_image').to_s
  end

  def image_from_layout
    case article.layout
    when 'full_image'
      h.image_tag article.image.show_full_image, alt: article.title, class: 'page-image'
    else
      h.image_tag article.image.show_right, alt: article.title, class: 'page-image'
    end
  end

  def image_caption
    h.content_tag :p, article.caption, class: 'article-caption'
  end

  def linked_index_image
    h.link_to article, title: article.title do
      if article.image?
        h.image_tag article.image.homepage, alt: article.title
      else
        h.image_tag 'placeholders/list-image.jpg', alt: article.title
      end
    end
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

  def has_image?
    article.image? ? true : false
  end

  def read_more
    h.link_to 'Read more', article, class: 'content-box-ghost-button'
  end
end
