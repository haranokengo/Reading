class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book, primary_key: "isbn"
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
