class SearchsController < ApplicationController
  before_action :authenticate_user!
  def search
    # カテゴリーの一覧をおすすめの横に表示するため
    @categories = Category.all
    # 重複している本を反映させないための処理
    book_ids = Review.select(:book_id).where(category_id: params[:category_id]).distinct.pluck(
      :book_id
    )
    @datas = Book.where(isbn: book_ids)
  end
end
