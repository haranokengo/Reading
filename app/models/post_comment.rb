class PostComment < ApplicationRecord
  validates :impression, presence: true, length: { minimum: 10, maximum: 150 }

  belongs_to :review
  belongs_to :user
end
