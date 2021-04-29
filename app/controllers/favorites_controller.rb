class FavoritesController < ApplicationController
  before_action :authenticate_user!
  # 共通メソッド「set_review」でまとめている
  before_action :set_review, only: [:create, :destroy]
  # いいね機能
  def create
    @favorite = current_user.favorites.new(review_id: @review.id)
    @favorite.save
  end

  def destroy
    @favorite = current_user.favorites.find_by(review_id: @review.id)
    @favorite.destroy
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end
end
