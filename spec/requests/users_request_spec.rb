require 'rails_helper'

describe "Users", type: :request do 

  it "create user" do 
    user = build(:user)
    attributes = {
      user: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        password: user.password,
        username: user.username

      }
    }

    headers = {"ACCEPT": "application/json"}
    post users_path, params: attributes, headers: headers
    expect(response).to have_http_status(:success)
  end

  it "show user" do 
    token = login['data']['token']
    user = create(:user)
    headers = {"ACCEPT": "application/json", "Authorization": token}
    get user_path(user), headers: headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    json = json['user']
    expect(json['id']).to eq(user.id)
    expect(json['first_name']).to eq(user.first_name)
    expect(json['last_name']).to eq(user.last_name)
    expect(json['email']).to eq(user.email)
    expect(json['username']).to eq(user.username)
  end

  it "update user" do 
    token = login['data']['token']
    user = create(:user)
    new_attributes = {
      user: {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: Faker::Lorem.characters(number: 10),
        username: Faker::Lorem.characters(number: 10)

      }
    }

    headers = {"ACCEPT": "application/json", "Authorization": token}
    put user_path(user), params: new_attributes, headers: headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    json = json['user']
    expect(json['id']).to eq(user.id)
    expect(json['first_name']).to eq(new_attributes[:user][:first_name])
    expect(json['last_name']).to eq(new_attributes[:user][:last_name])
    expect(json['email']).to eq(new_attributes[:user][:email])
    expect(json['username']).to eq(new_attributes[:user][:username])
  end

  it "delete user" do 
    token = login['data']['token']
    user = create(:user)
    headers = {"ACCEPT": "application/json", "Authorization": token}
    delete user_path(user),  headers: headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    json = json['user']
    expect(json['id']).to eq(user.id)
    expect(json['first_name']).to eq(user.first_name)
    expect(json['last_name']).to eq(user.last_name)
    expect(json['email']).to eq(user.email)
    expect(json['username']).to eq(user.username)
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
end
