FactoryGirl.define do
  factory :administrator, class: Optimadmin::Administrator do
    username 'optimised'
    email 'support@optimised.today'
    password 'optipoipoip'
    password_confirmation 'optipoipoip'
    role 'master'
  end
end