FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "HomTanks#{n}"}
    sequence(:email) { |n| "HTanks#{n}@gmail.com" }
    password "password"
  end
end
