FactoryGirl.define do
  factory :article_category do
    sequence(:title) {|n| "Category #{n}"}
    trait :member_related do
      member_related false
    end

    trait :with_articles do
      # default to 3 articles creates
      transient do
        articles_count 3
      end
      after(:create) do |article_category, evaluator|
        create_list(:article, evalutator.articles_count, article_category: article_category)
      end
    end

    factory :member_related_article_category, traits: [:member_related]
    factory :article_category_with_articles, traits: [:with_articles]
    factory :member_related_article_category_with_articles, traits: [:member_related, :with_articles]
  end

  factory :article do
    article_category
    sequence(:title) {|n| "My article title #{n}" }
    content "Some content"
    date Date.today
    sequence(:suggested_url) {|n| "my-article-#{ n }" }
    trait :with_image do
      image { File.open(File.join(Rails.root, "test/support/images/landscape_image.jpg")) }
    end
    factory :article_with_image, traits: [:with_image]
  end
end