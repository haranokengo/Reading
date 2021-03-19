class PostCommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.review_id = @review.id
    if @post_comment.save
      # 非同期通信をおこないコメントとレビューを紐付けるため、レビューの「id」を再度@reviewに渡している
      @review = Review.find(params[:review_id])
      @post_comment.review_id = @review.id
    elsif
      # 非同期通信をおこないコメントとレビューを紐付けるため、レビューの「id」を再度@reviewに渡している
      @review = Review.find(params[:review_id])
      @post_comment.review_id = @review.id
      render 'error'
    end
  end

  def destroy
    PostComment.find_by(id: params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:impression)
  end

end
