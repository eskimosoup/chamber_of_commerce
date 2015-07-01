FactoryGirl.define do
  factory :category do
    sequence(:title) {|n| "Category #{n}"}
  end

  factory :article do
    category
    title "My article title"
    content "Some content"
    date Date.today
    sequence(:suggested_url) {|n| "my-article-#{ n }" }
  end
end