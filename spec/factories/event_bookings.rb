FactoryGirl.define do
  factory :event_booking do
    event nil
    name "MyString"
    company_name "MyString"
    industry_type "MyString"
    nature_of_business "MyString"
    address "MyText"
    phone_number "MyString"
    email "MyString"
    paid false
  end

end
