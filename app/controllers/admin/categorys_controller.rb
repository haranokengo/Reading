class Admin::CategorysController < ApplicationController
  
  def edit
    @category = Category.find(params[:id])
  end

  def index
    @categorys = Category.all
    @category = Category.new
  end
  
  def create
    category = Category.new(category_params)
    category.save
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
end