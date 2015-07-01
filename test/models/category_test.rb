require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
  should have_many(:articles)

end