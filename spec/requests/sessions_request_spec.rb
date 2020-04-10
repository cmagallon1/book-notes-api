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

  it "destroy session" do 
    user = create(:user)
    headers = {"ACCEPT": "application/json"}
    credentials = {
      user: {
        email: user.email, 
        password: user.password
      }
    }
    post '/users/signin', params: credentials, headers: headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    token = json['data']['token']
    delete '/users/signout', headers: headers.merge("Authorization": token) 
    expect(response).to have_http_status(:success)
  end
end
