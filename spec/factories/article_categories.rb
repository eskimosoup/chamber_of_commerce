# == Schema Information
#
# Table name: article_categories
#
#  id             :integer          not null, primary key
#  member_related :boolean          default(FALSE)
#  slug           :string
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_article_categories_on_slug  (slug)
#
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
