require 'rails_helper'

describe "Books", type: :request do 
  context "without filter" do 
    it "show books" do 
      token = login['data']['token']
      headers = { "ACCEPT": "application/json", "Authorization": token }
      user = create(:user)
      book = build(:book, user_id: user.id)
      expect(book.save).to eq(true)
      get user_books_path(user), headers: headers
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['books']).to eq(book_attributes)
    end
  end

  context "with params" do 
    it "show books" do 
      token = login['data']['token']
      headers = { "ACCEPT": "application/json", "Authorization": token }
      user = create(:user)
      book = build(:book, user_id: user.id, category: 'fiction')
      expect(book.save).to eq(true)
      book2 = build(:book, user_id: user.id, category: 'ancient literature')
      expect(book2.save).to eq(true)
      get user_books_path(user), params: { filter: { field: 'category', value: 'fiction' }  }, headers: headers
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['books']).to eq([remove_params(book.attributes, "updated_at", "created_at")])
    end
  end

  it "show book" do 
    token = login['data']['token']
    headers = { "ACCEPT": "application/json", "Authorization": token }
    user = create(:user)
    book = build(:book, user_id: user.id)
    expect(book.save).to eq(true)
    get "/users/#{user.id}/books/#{book.id}", headers: headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json['book']).to eq(remove_params(book.attributes, "updated_at", "created_at"))
  end

  it "create book" do 
    token = login['data']['token']
    headers = { "ACCEPT": "application/json", "Authorization": token }
    user = create(:user)
    book = {
      book: {
        name: Faker::Name.name,
        author: Faker::Name.name,
        category: Faker::Lorem.word
      }
    }
    post user_books_path(user), params: book, headers: headers 
    expect(response).to have_http_status(:success)
  end

  it "update book" do 
    token = login['data']['token']
    headers = { "ACCEPT": "application/json", "Authorization": token }
    user = create(:user)
    book = build(:book, user_id: user.id)
    expect(book.save).to eq(true)
    new_attributes = {
      book: {
        name: Faker::Name.name,
        author: Faker::Name.name,
        category: Faker::Lorem.word
      }
    }
    put "/users/#{user.id}/books/#{book.id}", params: new_attributes, headers: headers 
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    json = json['book']
    expect(json['name']).to eq(new_attributes[:book][:name])
    expect(json['author']).to eq(new_attributes[:book][:author])
    expect(json['category']).to eq(new_attributes[:book][:category])
    expect(json['id']).to eq(book.id)
  end

  it "delete book" do 
    token = login['data']['token']
    headers = { "ACCEPT": "application/json", "Authorization": token }
    user = create(:user)
    book = build(:book, user_id: user.id)
    expect(book.save).to eq(true)
    delete "/users/#{user.id}/books/#{book.id}", headers: headers 
    expect(response).to have_http_status(:success)
  end

  def login
    user = build(:user, password: '12345')
    expect(user.save).to eq(true)
    headers = {"ACCEPT": "application/json"}
    credentials = {
      user: {
        email: user.email, 
        password: user.password
      }
    }
    post '/users/signin', params: credentials, headers: headers
    expect(response).to have_http_status(:success)
    JSON.parse(response.body)
  end

  def book_attributes
    Book.all.to_a.map do |book| 
      attributes = book.attributes
      remove_params(attributes, "updated_at", "created_at")
    end
  end

  def remove_params(hash, *args)
    args.each { |key| hash.delete(key)  }
    hash
  end
end
