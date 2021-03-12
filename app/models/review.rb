class Review < ApplicationRecord
  
  belongs_to :user
  # primary_keyをbook_idからisbn
  belongs_to :book, primary_key: "isbn"
  # dependent: :destroy 親モデルを削除する際に、その親モデルに紐づく子モデルも一緒に削除できる
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :category

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end
