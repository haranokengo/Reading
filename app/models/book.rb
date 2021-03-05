class Book < ApplicationRecord
  
  belongs_to :user
  # 画像アップ用
  attachment :image
  
end
