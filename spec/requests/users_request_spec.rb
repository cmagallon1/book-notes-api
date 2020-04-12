require 'rails_helper'

describe "Users", type: :request do 

  before do 
    @token = login['data']['token']
    @headers = {"ACCEPT": "application/json", "Authorization": @token}
    @user = create(:user)
    @user.reload
  end

  it "create user" do 
    headers = {"ACCEPT": "application/json"}
    post users_path, params: user_params, headers: headers
    expect(response).to have_http_status(:success)
  end

  it "show user" do 
    get user_path(@user.uuid), headers: @headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    json = json['user']
    expect(json['id']).to eq(@user.id)
    expect(json['first_name']).to eq(@user.first_name)
    expect(json['last_name']).to eq(@user.last_name)
    expect(json['email']).to eq(@user.email)
    expect(json['username']).to eq(@user.username)
  end

  it "update user" do 
    new_attributes = user_params
    put user_path(@user.uuid), params: new_attributes, headers: @headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    json = json['user']
    expect(json['id']).to eq(@user.id)
    expect(json['first_name']).to eq(new_attributes[:user][:first_name])
    expect(json['last_name']).to eq(new_attributes[:user][:last_name])
    expect(json['email']).to eq(new_attributes[:user][:email])
    expect(json['username']).to eq(new_attributes[:user][:username])
  end

  it "delete user" do 
    delete user_path(@user.uuid), headers: @headers
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    json = json['user']
    expect(json['id']).to eq(@user.id)
    expect(json['first_name']).to eq(@user.first_name)
    expect(json['last_name']).to eq(@user.last_name)
    expect(json['email']).to eq(@user.email)
    expect(json['username']).to eq(@user.username)
  end

  def user_params
    {
      user: {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: Faker::Lorem.characters(number: 10),
        username: Faker::Lorem.characters(number: 10)

      }
    }
  end
end
