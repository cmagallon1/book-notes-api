class BooksController < ApplicationController
  before_action :authorization
  before_action :find_book, except: [:index, :create]

  def index
    @books = params[:filter].blank? ? Book.where(user_id: params[:user_id]) : Book.books(filter_params)
  end

  def create
    @book = Book.new(book_params.merge(user_id: params[:user_id]))
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
