require 'rails_helper'

describe 'sessions', type: :request do 
  it "create session" do 
    user = create(:user)
    headers = {"ACCEPT": "application/json"}
    user = {
      user: {
        email: user.email,
        password: user.password
      }
    }
    post '/users/signin', params: user, headers: headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json['data'].key?('token')).to eq(true)
    expect(json['data'].key?('username')).to eq(true)
    expect(json['data'].key?('exp')).to eq(true)
    expect(json['data'].key?('uuid')).to eq(true)
  end

  it "destroy session" do 
    login
    delete '/users/signout'
    expect(response).to have_http_status(:success)
  end
end
