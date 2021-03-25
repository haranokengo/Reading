class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_user, only: :new

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    # current_userに紐付いているreviewを保存するために取得
    @review = current_user.reviews.new(review_params)
    # book_idに紐付いているreviewを保存するために取得
    @review.book_id = @book.id
    if @review.save
      redirect_to book_path(@book)
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
