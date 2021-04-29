class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @book = Book.find_by(isbn: params[:isbn])
    @post_comment = PostComment.new
  end

  def search
    # viewから@titleを持ってくる
    @title = params[:title]
    if @title.present?
      # resultsに楽天APIから取得したデータ（jsonデータ）を格納する
      # 書籍のタイトルを検索して、一致するデータを格納するように設定
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })
      # この部分で「@books」にAPIからの取得したJSONデータを格納
      # read(result)は、privateメソッドとして、設定
      @books = results.map { |result| Book.new(read(result)) }
    end
    # 「@books」内の各データをそれぞれ保存
    # 取得したデータがあればeachでまわす
    if @books.present?
      @books.each do |book|
        # 楽天booksから取得した「isbn」がbookモデルになければsave
        book.save if Book.find_by(isbn: book.isbn).nil?
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
