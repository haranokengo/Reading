class LikesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
  end

  def create
    @book = Book.find(params[:book_id])
    @like = Like.create(user_id: current_user.id, book_id: @book.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    @like = Like.find_by(user_id: current_user.id, book_id: @book.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

end
