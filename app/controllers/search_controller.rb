class SearchController < ApplicationController
  
  def search
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    # search_forアクションでReviewモデルから対象のcategory_idと紐付いたreviewを@datasに格納
    @datas = search_for(@how, @value)
  end
  
  private
  
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
