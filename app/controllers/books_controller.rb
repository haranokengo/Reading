class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @post = Post.new
  end

  def search
    # 空の配列を作成
    @books = []
    # paramsでtitleを持ってくる
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
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
