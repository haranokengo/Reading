FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    nickname { Faker::Lorem.characters(number: 10) }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
