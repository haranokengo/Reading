class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
  end

  def search
    # 空の配列を作成
    @books = []
    # paramsでtitleを持ってくる
    @title = params[:title]
    if @title.present?
      #resultsに楽天APIから取得したデータ（jsonデータ）を格納する
      #書籍のタイトルを検索して、一致するデータを格納するように設定
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })
      #この部分で「@books」にAPIからの取得したJSONデータを格納
      #read(result)については、privateメソッドとして、設定
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
    #「@books」内の各データをそれぞれ保存
    #すでに保存済の本は除外するためにunlessの構文を記載
    @books.each do |book|
      unless Book.all.include?(book)
        book.save
      end
    end
  end

  private

  def read(result)
    title = result["title"]
    author = result["author"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"]
    {
      title: title,
      author: author,
      url: url,
      isbn: isbn,
      image_url: image_url,
    }
  end
end
