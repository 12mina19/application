class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book.id)
    #投稿ボタンを押した後は詳細画面（show）に移動する
      flash[:complete] = "Book was successfully created."
    else
      @books = Book.all
      render :index
    end
  end
  
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:complete] = "Book was successfully updated."
    else
      render :show
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
    #削除した後は、投稿一覧の画面に戻る
    flash[:complete] = "Book was successfully destroyed."
  end
  
  private
  #ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
