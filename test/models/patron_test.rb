require 'test_helper'

class PatronTest < ActiveSupport::TestCase

  should validate_presence_of(:name)
  should validate_presence_of(:image)

end