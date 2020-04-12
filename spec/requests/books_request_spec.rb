require 'rails_helper'

describe "Books", type: :request do 

  before do 
    @token = login['data']['token']
    @user = create(:user)
    @user.reload
    @headers = { "ACCEPT": "application/json", "Authorization": @token }
  end

  context "without filter" do 
    it "show books" do 
      book = build(:book, user_id: @user.id)
      expect(book.save).to eq(true)
      get user_books_path(@user.uuid), headers: @headers
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['books']).to eq(book_attributes)
    end
  end

  context "with params" do 
    it "show books" do 
      book = build(:book, user_id: @user.id, category: 'fiction')
      expect(book.save).to eq(true)
      book2 = build(:book, user_id: @user.id, category: 'ancient literature')
      expect(book2.save).to eq(true)
      get user_books_path(@user.uuid), params: { filter: { field: 'category', value: 'fiction' }  }, headers: @headers
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['books']).to eq([remove_params(book.attributes, "updated_at", "created_at")])
    end
  end

  it "show book" do 
    book = build(:book, user_id: @user.id)
    expect(book.save).to eq(true)
    get "/users/#{@user.uuid}/books/#{book.id}", headers: @headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json['book']).to eq(remove_params(book.attributes, "updated_at", "created_at"))
  end

  it "create book" do 
    post user_books_path(@user.uuid), params: book_params, headers: @headers 
    expect(response).to have_http_status(:success)
  end

  it "update book" do 
    book = build(:book, user_id: @user.id)
    expect(book.save).to eq(true)
    new_attributes = book_params
    put "/users/#{@user.uuid}/books/#{book.id}", params: new_attributes, headers: @headers 
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    json = json['book']
    expect(json['name']).to eq(new_attributes[:book][:name])
    expect(json['author']).to eq(new_attributes[:book][:author])
    expect(json['category']).to eq(new_attributes[:book][:category])
    expect(json['id']).to eq(book.id)
  end

  it "delete book" do 
    book = build(:book, user_id: @user.id)
    expect(book.save).to eq(true)
    delete "/users/#{@user.uuid}/books/#{book.id}", headers: @headers 
    expect(response).to have_http_status(:success)
  end

  def book_params
    {
      book: {
        name: Faker::Name.name,
        author: Faker::Name.name,
        category: Faker::Lorem.word
      }
    }
  end
end
