FactoryGirl.define do
  factory :article_category do
    sequence(:title) {|n| "Category #{n}"}
  end

  factory :article do
    article_category
    title "My article title"
    content "Some content"
    date Date.today
    sequence(:suggested_url) {|n| "my-article-#{ n }" }
    factory :article_with_image do
      image { File.open(File.join(Rails.root, "test/support/images/landscape_image.jpg")) }
    end
  end
end