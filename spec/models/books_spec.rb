require 'rails_helper'

RSpec.describe "Books", type: :models do
  describe "validations" do 

    before do
      create(:user)
    end

    context "empty" do 
      it "book" do 
        book = Book.new
        expect(book).not_to be_valid
      end

      it "author" do
        book = build(:book, author: nil)
        expect(book).not_to be_valid
      end

      it "category" do
        book = build(:book, category: nil)
        expect(book).not_to be_valid
      end

      it "status" do
        book = create(:book)
        book.status = nil
        expect(book).not_to be_valid
      end

      it "name" do
        book = build(:book, name: nil)
        expect(book).not_to be_valid
      end
    end

    it "validate initial status" do 
      book = create(:book)
      expect(book.status).to eq("awaiting")
    end

    context "uniqueness" do 
      it "valid book with same name" do 
        name = Faker::Name.name
        book = build(:book, name: name)
        expect(book.save).to eq(true)
        book = build(:book, name: name)
        expect(book).not_to be_valid
      end
    end

    it "valid with all params" do 
      book = build(:book)
      expect(book).to be_valid
    end

    it "validate books scope" do 
      book = build(:book, category: "fiction")
      expect(book.save).to eq(true)
      book2 = build(:book, category: "fiction")
      expect(book2.save).to eq(true)
      expect(Book.books(field: "category", value: 'fiction')).to eq([book, book2])
    end
  end
end
