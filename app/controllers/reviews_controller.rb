class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_user, only: [:new, :destroy, :create]

  def new
    @book = Book.find_by(isbn: params[:book_isbn])
    @review = Review.new
  end

  def create
    @book = Book.find_by(isbn: params[:book_isbn])
    # current_userに紐付いているreviewを保存するために取得
    @review = current_user.reviews.new(review_params)
    # book_idに紐付いているreviewを保存するために取得
    @review.book = @book
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
