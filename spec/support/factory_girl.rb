FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "HomTanks#{n}" }
    sequence(:email) { |n| "HTanks#{n}@gmail.com" }
    password "password"
  end
  factory :household do
    sequence(:address) { |n| "#{n} Summer Dr." }
    city "Boston"
    state "MA"
    zip "12345"
    user
  end
  factory :bill do
    household
    sequence(:amount) { |n| n }
    date "12/12/2015"
    kind "Electric"
  end
  factory :utilitydata do
    sequence(:amount) { |n| 100 + n }
    date "12/12/2015"
    state "MA"
    kind "Electric"
  end
end
