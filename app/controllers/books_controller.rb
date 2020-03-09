class BooksController < ApplicationController

  before_action :authorization

  def index
    @books = params.keys.include?('filter') ? filter_books(params[:filter], params[:name]) : filter_books("user_id", @current_user)
  end

  def show
    @book = Book.find(params[:id])
  end

  def show_by_user
    @books = Book.where(user_id: params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.save
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :status, :user_id, :category)
  end

  def filter_books(filter, name)
      Book.where("#{filter} = ?", name)
  end
end
