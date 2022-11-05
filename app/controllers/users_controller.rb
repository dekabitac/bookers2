class UsersController < ApplicationController

  def new
    @user = User.new(user_params)
    @user.save
      flash[:notice] = "Welcome! You have signed up successfully."
    redirect_to user_path(current_user.id)
  end

  def create
    @user = User.new(user_params)
    if@user.save
      flash[:notice] = "Signed in successfully."
      redirect_to users_path(current.id)
    else
      redirect_to books_path
    end
  end

  def index
    @users = User.all
    @book_new = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to  user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if@user.save
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path
    else
      render :edit
    end
  end


private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
