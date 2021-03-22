class SearchsController < ApplicationController
  def search
    # 年代を「category_id」valueとして取得
    @value = params["search"]["value"]
    # privateでhowを定義
    @how = params["search"]["how"]
    # search_forアクションでReviewモデルから対象のcategory_idと紐付いたreviewを@datasに格納
    @datas = search_for(@how, @value)
  end

  private

  # 選択された年代「category_id」を探してもらう
  def match(value)
    Review.where(category_id: value)
  end

  def search_for(how, value)
    case how
    when 'match'
      match(value)
    end
  end
end
