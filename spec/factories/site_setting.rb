FactoryGirl.define do
  factory :site_setting, class: Optimadmin::SiteSetting do
    environment "test"
    trait :name do
      key 'Name'
      value 'Chamber of Commerce'
    end

    trait :email do
      key 'Email'
      value 'support@optimised.today'
    end
    factory :site_setting_name, traits: [:name]
    factory :site_setting_email, traits: [:email]
  end
end