require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  should validate_presence_of(:title)
  should validate_presence_of(:content)
  should validate_presence_of(:date)
  should validate_presence_of(:article_category_id)
  should belong_to(:article_category)

  should "validate uniqueness" do
    build(:article)
    validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically')
  end

  context "friendly_id" do
    setup do
      @article = build(:article)
    end

    should "create slug as title changed" do
      @article.title = "My new title"
      assert @article.should_generate_new_friendly_id?
    end

    should "create slug as suggested_url changed" do
      @article.suggested_url = "my-new-titled-article"
      assert @article.should_generate_new_friendly_id?
    end

    should "not create slug when other attributes changed" do
      article = create(:article)
      article.content = "Gobbledegook"
      refute article.should_generate_new_friendly_id?
    end

  end

end