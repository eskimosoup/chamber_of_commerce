require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  should validate_presence_of(:title)
  should validate_presence_of(:content)
  should validate_presence_of(:date)
  should belong_to(:category)

  should "validate uniqueness" do
    Article.new(title: "title")
    validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically')
  end


end