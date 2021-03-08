class Public::ReviewsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    content = current_user.reviews.new(review_params)
    content.book_id = book.id
    content.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    Review.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content)
  end
  
end
