class ArticleCategoryPresenter < BasePresenter
  presents :article_category

  def id
    article_category.id
  end

  def linked_title(options = {})
    h.link_to article_category.title, article_category, options
  end

  def class_name
    article_category.class.name.downcase
  end

  def title
    article_category.title
  end
end
