class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :nickname, presence: true, length: { minimum: 2, maximum: 20 }
  # ニックネームが被らないように
  validates :nickname, uniqueness: true
  validates :email, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image
  has_many :reviews, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy

  # フォロー取得
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  # フォロワー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower
  # ユーザーをフォローする（relationships_controllerで使用する）
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す（relationships_controllerで使用する）
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す（viewの条件分岐の時に使用する）
  def following?(user)
    following_user.include?(user)
  end

  # session_controllerで使用
  def self.guest
    # ゲストユーザーが仮に削除されたとしても、機能するようにしている
    find_or_create_by!(email: 'guest@example.com',) do |user|
      # パスワードをランダムに設定している
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.nickname = "ゲスト"
    end
  end
end
