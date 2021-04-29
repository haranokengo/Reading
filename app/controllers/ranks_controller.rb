class RanksController < ApplicationController
  before_action :authenticate_user!
  def index
    # 最近レビューされた本を表示するために使う（５件取得）
    @reviews = Review.all.order(created_at: :desc).limit(5)
    # ランキング表示に使う（上位３つを取得）
    @all_ranks = Book.find(
      Review.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id)
    )
  end
end
