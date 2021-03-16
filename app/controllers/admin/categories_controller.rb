class Admin::CategoriesController < ApplicationController

  def edit
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    category.save
    redirect_back(fallback_location: root_path)
  end

  def update
    category = Category.find(params[:id])
    category.update(category_params)
    redirect_to admin_categories_path
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