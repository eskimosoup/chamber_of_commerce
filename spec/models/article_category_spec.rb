require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do

  describe "validations", :validation do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end

  describe "associations", :association do
    it { should have_many(:articles) }
  end

  describe "friendly_id" do
    subject(:article_category) { build(:article_category) }

    it "creates a new slug if title changed" do
      article_category.title = "My new title"
      expect(article_category.should_generate_new_friendly_id?).to be true
    end
  end
end
