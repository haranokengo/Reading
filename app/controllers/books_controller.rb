class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @book = Book.find_by(params[:isbn])
    @post_comment = PostComment.new
  end

  def search
    # paramsでtitleを持ってくる
    @title = params[:title]
    # 早期return
    # return unless @title.present?
    
    if @title.present?
      # resultsに楽天APIから取得したデータ（jsonデータ）を格納する
      # 書籍のタイトルを検索して、一致するデータを格納するように設定
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })
      # この部分で「@books」にAPIからの取得したJSONデータを格納
      # read(result)については、privateメソッドとして、設定
      @books = results.map { |result| Book.new(read(result)) }
      #@books = results.map do |result|
      #  book = Book.new(read(result))
      #  Book.find_or_create_by(isbn: book.isbn)
      #end
    end
    # 「@books」内の各データをそれぞれ保存
    # 取得したデータがあればeachでまわす
    if @books.present?
      @books.each do |book|
        # 楽天booksから取得した「isbn」がbookモデルになければsave
        if Book.find_by(isbn: book.isbn).nil?
          book.save
        end
        
        # one liner 後置if
        # book.save if Book.find_by(isbn: book.isbn).nil?
        
        # Rails like (on rails)
        # Book.find_or_create_by(isbn: book.isbn)
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
