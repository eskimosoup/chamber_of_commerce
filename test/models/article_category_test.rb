require 'test_helper'

class ArticleCategoryTest < ActiveSupport::TestCase

  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
  should have_many(:articles)
  should have_db_column(:member_related)

  context "friendly_id" do
    setup do
      @article_category = build(:article_category)
    end

    should "create slug as title changed" do
      @article_category.title = "My new title"
      assert @article_category.should_generate_new_friendly_id?
    end
  end

end