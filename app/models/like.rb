class Like < ApplicationRecord
  belongs_to :book, primary_key: "isbn"
  belongs_to :user
  # is_activeのカラムをboolean型で作成 {true: 読んだ, false: 読んでいない}
  validates :is_active, inclusion: { in: [true, false] }
end
