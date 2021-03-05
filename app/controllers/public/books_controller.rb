class Public::BooksController < ApplicationController
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    # とりあえず前に戻る
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    # とりあえず前に戻る
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def book_params
    params.require(:book).permit(:image, :title, :author, :description)
  end

end
