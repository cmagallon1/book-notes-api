module Helpers
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
