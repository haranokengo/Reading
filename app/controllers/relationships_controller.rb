class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  # 「follow」「unfollow」メソッドはuserモデルで定義
  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end
end
