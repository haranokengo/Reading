class PostsController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    impression = current_user.posts.new(post_params)
    impression.review_id = review.id
    impression.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Post.find_by(id: params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  def post_params
    params.require(:post).permit(:impression)
  end
end
