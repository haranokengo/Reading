class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.new(review_params)
    @review.book_id = @book.id
    if @review.save
      redirect_to book_path(book)
    else
      render :new
    end
  end

  def destroy
    Review.find_by(id: params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:content, :category_id)
  end

end
