class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def edit
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_back(fallback_location: root_path)
    else
      @categories = Category.all
      render :index
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "入力が保存されました"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "入力画面が未入力です"
      render "edit"
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
