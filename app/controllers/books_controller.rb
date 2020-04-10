class BooksController < ApplicationController
  before_action :authorization
  around_action :catch_errors
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
    params.require(:filter).permit(:filter, :value)
  end

  def catch_errors
    yield
  rescue ActiveRecord::RecordNotFound => err
    render json: { ok: false, status: 404, err: err }
  rescue ActiveRecord::RecordInvalid => err
    render json: { ok: false, status: 400, err: err }
  end
end
