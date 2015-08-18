FactoryGirl.define do
  factory :attendee do
    association :event_booking, strategy: :build
    phone_number "MyString"
    sequence(:email) {|n| "example#{ n }@example.com" }
    dietary_requirements "MyText"
    event_agendas { create_list(:event_agenda, rand(1..3)) }
  end

end
