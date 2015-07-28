FactoryGirl.define do
  factory :article do
    article_category
    sequence(:title) {|n| "My article title #{n}" }
    content "Some content"
    date Date.today
    sequence(:suggested_url) {|n| "my-article-#{ n }" }
    trait :with_image do
      image { File.open(File.join(Rails.root, "spec/support/images/landscape_image.jpg")) }
    end
    factory :article_with_image, traits: [:with_image]
  end
end