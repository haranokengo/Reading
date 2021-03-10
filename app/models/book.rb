class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :categories
end
