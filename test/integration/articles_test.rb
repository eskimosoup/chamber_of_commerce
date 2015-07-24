require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest

  def assert_articles_index
    visit articles_url
    assert_equal articles_url, current_url
  end

  def assert_article_show_page(article)
    assert_equal article_url(article), current_url
  end

  context "articles index page without any articles" do
    should "have no articles message" do
      assert_articles_index
      within("h1") do
        assert has_content? "News"
      end
      assert has_content? "Currently no articles"
    end
  end

  context "viewing article" do
    setup do
      @article = create(:article_with_image)
      @presented_article = ArticlePresenter.new(object: @article, view_template: view)
    end

    should "have articles displayed on index" do
      assert_articles_index
      assert has_link?(@presented_article.title)
      assert_selector(".article", count: 1)
    end

    should "be able to view show page" do
      assert_articles_index
      within(".main-content-wrap") do
        click_link(@presented_article.title)
      end
      assert_article_show_page(@presented_article)
      within("h1") do
        assert has_content? @presented_article.title
      end
      assert has_content? @presented_article.content
      assert_equal page.find("#article-image-#{@presented_article.id}")['src'], @article.image.show.url
    end
  end

  #context "articles index page should not display member related articles" do
#
 # end
end
