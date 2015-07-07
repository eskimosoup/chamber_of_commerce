require 'test_helper'

class ArticlePresenterTest < ActionView::TestCase

  context "standard article accessing model attributes" do
    setup do
      @article = create(:article)
      @article_presenter = ArticlePresenter.new(object: @article, view_template: view)
    end

    should "return article id" do
      assert_equal @article.id, @article_presenter.id
    end

    should "return downcased article class_name" do
      assert_equal @article.class.name.downcase, @article_presenter.class_name
    end

    should "return article title" do
      assert_equal @article.title, @article_presenter.title
    end
  end

  context "article without image" do
    setup do
      @article = create(:article)
      @article_presenter = ArticlePresenter.new(object: @article, view_template: view)
    end

    should "link title without options" do
      link = link_to @article.title, @article
      assert_equal link, @article_presenter.linked_title
    end

    should "link title with options" do
      link = link_to @article.title, @article, class: "my-class"
      assert_equal link, @article_presenter.linked_title(class: "my-class")
    end

    should "format date to long by default" do
      date = l @article.date, format: :long
      assert_equal date, @article_presenter.date
    end

    should "format date to set format" do
      date = l @article.date, format: :short
      assert_equal date, @article_presenter.date(:short)
    end

    should "correctly escape html on summary" do
      assert_equal raw(@article.summary), @article_presenter.summary
    end

    should "correctly escape html on content" do
      assert_equal raw(@article.content), @article_presenter.content
    end

    should "return nil when image method called" do
      assert_nil @article_presenter.image
    end

    should "return default home image" do
      # need to use view. here - see https://github.com/rails/rails/issues/7218
      linked_image = link_to view.image_tag('placeholders/home-slider.jpg', alt: @article.title), @article, title: @article.title
      assert_equal linked_image, @article_presenter.linked_home_image
    end
  end

  context "article with an image" do
    setup do
      @article = create(:article_with_image)
      @article_presenter = ArticlePresenter.new(object: @article, view_template: view)
    end

    should "return image when image method called" do
      assert_equal image_tag(@article.image.show, alt: @article.title, class: 'page-image image-right'), @article_presenter.image
    end

    should "return default home image" do
      linked_image = link_to image_tag(@article.image.homepage, alt: @article.title), @article, title: @article.title
      assert_equal linked_image, @article_presenter.linked_home_image
    end
  end
end