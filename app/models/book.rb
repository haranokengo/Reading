class Book < ApplicationRecord
  # bookに紐付いたレビューなどをしていくためのprimary_keyをisbnに変更
  self.primary_key = "isbn"
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy

  def to_params
    isbn.to_s
  end
end
