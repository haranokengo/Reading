class Category < ApplicationRecord
  validates :name, presence: true

  has_many :reviews, dependent: :destroy
end
