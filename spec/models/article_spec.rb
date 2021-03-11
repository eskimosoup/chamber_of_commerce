# == Schema Information
#
# Table name: articles
#
#  id                  :integer          not null, primary key
#  caption             :string
#  content             :text
#  date                :datetime
#  display             :boolean          default(TRUE)
#  image               :string
#  layout              :string           default("full_image")
#  slug                :string
#  suggested_url       :string
#  summary             :text
#  title               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  article_category_id :integer
#
# Indexes
#
#  index_articles_on_article_category_id  (article_category_id)
#  index_articles_on_slug                 (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (article_category_id => article_categories.id)
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:article_category) }
    it "should validate uniqueness" do
      build(:article)
      validate_uniqueness_of(:suggested_url).allow_blank.with_message('is not unique, leave this blank to generate automatically')
    end
  end

  describe "associations", :association do
    it { should belong_to(:article_category) }
  end

  describe "friendly_id" do
    subject(:article) { build(:article) }

    it "creates a slug if title changed" do
      article.title = "My new title"
      expect(article.should_generate_new_friendly_id?).to be true
    end

    it "creates a slug if suggested_url changed" do
      article.suggested_url = "my-new-titled-article"
      expect(article.should_generate_new_friendly_id?).to be true
    end

    it "does not create slug when other attributes changed" do
      article = create(:article)
      article.content = "Gobbledegook"
      expect(article.should_generate_new_friendly_id?).to be false
    end
  end
end
