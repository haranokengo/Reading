FactoryBot.define do
  factory :post_comment do
    impression { Faker::Lorem.characters(number: 10) }
    user
    review
  end
end
