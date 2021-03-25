FactoryBot.define do
  factory :review do
    content { Faker::Lorem.characters(number:10) }
    select '10代', from: 'category[category_id]'
    book
  end
end
