class RanksController < ApplicationController

  def index
    #新しい順の投稿一覧(descは降順)
    @reviews = Review.all.order(created_at: :desc).limit(5)
    @all_ranks = Book.find(Review.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))
  end

end
