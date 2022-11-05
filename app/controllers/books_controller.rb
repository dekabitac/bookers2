class BooksController < ApplicationController
   before_action :correct_user, only: [:edit, :update]
   
  def new
    @book = Book.new
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @user = current_user
      @book = Book.all
      render :index
    end
  end

  def index
    @book_new = Book.new
    @book = Book.all
    @user = current_user
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to  book_path(@book.id)
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if@book.save
    flash[:notice] = "You have update book successfully."
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
