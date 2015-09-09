FactoryGirl.define do
  factory :member do
    email "paul@optimised.today"
    sequence(:company_name) { |n| "Company #{n}" }
    address "address"
    telephone "telephone"
    website "website"
    nature_of_business "nature of business"
  end
end
