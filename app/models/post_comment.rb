class PostComment < ApplicationRecord
  validates :impression, presence: true, length: { maximum: 150 }

  belongs_to :review
  belongs_to :user
end
