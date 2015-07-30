require 'rails_helper'

RSpec.feature "Article Pages", type: :feature do
  describe "articles index page without any articles" do
    it "has no articles message" do
      expect_articles_index
      within("h1") do
        assert has_content? "News"
      end
      assert has_content? "Currently no articles"
    end
  end

  describe "viewing article" do
    let!(:article) { create(:article_with_image) }

    it "has articles displayed on index" do
      expect_articles_index
      #save_and_open_page
      expect(page).to have_link(article.title)
      expect(page).to have_selector(".list-item-with-image", count: 1)
    end

    it "will go to the show page" do
      expect_articles_index
      within(".main-content-wrap h2") do
        click_link(article.title)
      end
      expect_article_show_page(article)
      within("h1") do
        expect(page).to have_content(article.title)
      end
      expect(page).to have_content(article.content)
    end
  end

  def expect_articles_index
    visit articles_url
    expect(current_url).to eq(articles_url)
  end

  def expect_article_show_page(article)
    expect(current_url).to eq(article_url(article))
  end
end
