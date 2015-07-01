class ArticlePresenter < BasePresenter
  presents :article

  def linked_title(options = {})
    h.link_to article.title, article, options
  end
end