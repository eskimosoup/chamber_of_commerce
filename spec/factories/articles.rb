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
FactoryGirl.define do
  factory :article do
    article_category
    sequence(:title) {|n| "My article title #{n}" }
    layout { Article.layouts.first }
    content "Some content"
    date Date.today
    caption "My image caption"
    sequence(:suggested_url) {|n| "my-article-#{ n }" }
    trait :with_image do
      image { File.open(File.join(Rails.root, "spec/support/images/landscape_image.jpg")) }
    end
    factory :article_with_image, traits: [:with_image]
  end
end
