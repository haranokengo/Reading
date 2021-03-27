FactoryBot.define do
  factory :review do
    content { Faker::Lorem.characters(number:10) }
    category
    book
    user
  end
end
