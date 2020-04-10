require 'rails_helper'

RSpec.describe "Books", type: :models do
  context "with empty values" do 
    it "valid without values" do 
      book = Book.new
      expect(book).not_to be_valid
    end
    it "valid without author" do
      create(:user)
      book = build(:book, author: nil)
      expect(book).not_to be_valid
    end

    it "valid without category" do
      create(:user)
      book = build(:book, category: nil)
      expect(book).not_to be_valid

    end

    it "valid without status" do
      create(:user)
      book = create(:book)
      book.status = nil
      expect(book).not_to be_valid
    end

    it "valid without name" do
      create(:user)
      book = build(:book, name: nil)
      expect(book).not_to be_valid
    end
  end

  describe "validations" do 
    it "validate initial status" do 
      create(:user)
      book = create(:book)
      expect(book.status).to eq("awaiting")
    end



    it "valid book with same name" do 
      create(:user)
      name = Faker::Name.name
      book = build(:book, name: name)
      expect(book.save).to eq(true)
      book = build(:book, name: name)
      expect(book).not_to be_valid
    end
  end

  it "valid with all params" do 
    create(:user)
    book = build(:book)
    expect(book).to be_valid
  end

  it "validate books scope" do 
    create(:user)
    book = build(:book, category: "fiction")
    expect(book.save).to eq(true)
    book2 = build(:book, category: "fiction")
    expect(book2.save).to eq(true)
    expect(Book.books(field: "category", value: 'fiction')).to eq([book, book2])
  end
end
