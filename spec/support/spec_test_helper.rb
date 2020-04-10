module SpecTestHelper 
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
    post '/signin', params: credentials, headers: headers
  end
end

