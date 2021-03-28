FactoryBot.define do
  factory :book do
    title { 'book_test_title' }
    author { 'book_test_author' }
    url { 'book_test_url' }
    image_url { 'book_test_image_url' }
    # primary_keyに設定しているので、一意性を保つため
    sequence(:isbn) { |n| n + 1000 }
  end
end
