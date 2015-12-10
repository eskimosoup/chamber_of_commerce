FactoryGirl.define do
  factory :page do
    sequence(:title) {|n| "My page title #{n}" }
    content "Some content"
  end
end