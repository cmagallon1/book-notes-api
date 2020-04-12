class BooksController < ApplicationController
  before_action :authorization
  before_action :find_book, except: [:index, :create]
  before_action only: [:index, :create] do 
    current_user(:user_id)
  end

  def index
    @books = params[:filter].blank? ? @current_user.books : @current_user.books.books(filter_params)
  end

  def create
    @book = @current_user.books.new(book_params)
    @book.save!
  end

  def update
    @book.update!(book_params)
  end

  def destroy
    @book.delete
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :status, :category)
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def filter_params
    params.require(:filter).permit(:field, :value)
  end
end
