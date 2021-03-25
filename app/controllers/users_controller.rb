class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_user, only: :update

  def show
    @user = User.find(params[:id])
    @categories = Category.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "入力が保存されました"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "入力画面が未入力です"
      render "edit"
    end
  end

  def follower
    @user = User.find(params[:id])
    @users = @user.following_user
  end

  def followed
    @user = User.find(params[:id])
    @users = @user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :nickname, :email)
  end
end
