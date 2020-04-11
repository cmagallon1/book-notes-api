require 'rails_helper'

describe 'sessions', type: :request do 
  it "create session" do 
    user = create(:user)
    user = {
      user: {
        email: user.email,
        password: user.password
      }
    }
    post '/users/signin', params: user
    expect(response).to have_http_status(:success)
  end
end
