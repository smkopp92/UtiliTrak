FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "HomTanks#{n}" }
    sequence(:email) { |n| "HTanks#{n}@gmail.com" }
    password "password"
  end
  factory :household do
    address "12 Summer Dr."
    city "Boston"
    state "MA"
    zip "12345"
    user
  end
end
