class LikesController < ApplicationController
  before_action :authenticate_user!
  # お気に入り（読みたい本）機能
  def index
    # 読みたい本（お気に入り）一覧をviewに渡すためにuser情報を取得
    @user = User.find(params[:user_id])
    @categories = Category.all
  end

  def readed_all
    # 読んだ本一覧をviewに渡すために取得
    @user = User.find(params[:user_id])
    @categories = Category.all
  end

  def create
    @book = Book.find_by(params[:isbn])
    # user_idとbook_idに結びついたlike_idにデータを格納
    Like.create(user_id: current_user.id, book_id: @book.isbn)
  end

  def update
    like = Like.find(params[:id])
    like.update(like_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find_by(params[:isbn])
    # user_idとbook_idに結びついたlike_idにデータを削除
    like = Like.find_by(user_id: current_user.id, book_id: @book.isbn)
    like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:is_active)
  end
end
