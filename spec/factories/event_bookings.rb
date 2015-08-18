FactoryGirl.define do
  factory :event_booking do
    event
    name "MyString"
    company_name "MyString"
    industry "MyString"
    nature_of_business "MyString"
    address "MyText"
    phone_number "MyString"
    email "MyString"
    paid false
  end

end
