class Review < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  # primary_keyをbook_idからisbn
  belongs_to :book, primary_key: "isbn"
  # dependent: :destroy 親モデルを削除する際に、その親モデルに紐づく子モデルも一緒に削除できる
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :category

  # 同じ投稿に対していいねを２回することができないようにするためuser_idの確認をしている
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
