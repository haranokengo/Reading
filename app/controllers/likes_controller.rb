class LikesController < ApplicationController
  before_action :authenticate_user!
  # 共通メソッド「set_like」でまとめている
  before_action :set_like, only: [:index, :readed_all]

  # 読みたい本（お気に入りの中の）一覧をviewに渡すためにuser情報を取得
  def index
  end

  # 読んだ本(お気に入りの中の)一覧をviewに渡すために取得
  def readed_all
  end

  def create
    @book = Book.find_by(isbn: params[:book_isbn])
    # user_idとbook_idに結びついたlike_idにデータを格納
    Like.create(user_id: current_user.id, book_id: @book)
  end

  def update
    like = Like.find(params[:id])
    like.update(like_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find_by(isbn: params[:book_isbn])
    # user_idとbook_idに結びついたlike_idにデータを削除
    like = Like.find_by(user_id: current_user.id, book_id: @book.isbn)
    like.destroy
  end

  private

  def set_like
    @user = User.find(params[:user_id])
    @categories = Category.all
  end

  def like_params
    params.require(:like).permit(:is_active)
  end
end
