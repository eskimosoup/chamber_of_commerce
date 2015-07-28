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
end