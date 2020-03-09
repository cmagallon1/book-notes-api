require 'test_helper'
require 'pry'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def after_setup
    create(:user)
  end

  def test_save_book_without_params
    book = Book.new
   assert_not book.save, "Book saved without params"
  end

  def test_save_book
    assert create(:book), "Book not saved"
  end

  def test_save_book_without_name
    book = build(:book, name: '')
    assert_not book.save, "Book saved without name"
  end

  def test_save_book_without_author
    book = build(:book, author: '')
    assert_not book.save, 'Book saved without author'
  end

  def test_save_book_without_status
    book = build(:book, status: '')
    assert_not book.save, 'Book saved without status'
  end

  def test_initial_book_status_is_awaiting
    book = create(:book)
    assert_equal "awaiting", book.status, "initial status is not awaitning"
  end

end
