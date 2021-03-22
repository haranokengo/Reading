class Relationship < ApplicationRecord
  # userモデルで定義したクラス(follower,followed)とアソシエーション
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
