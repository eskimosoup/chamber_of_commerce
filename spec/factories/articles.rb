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