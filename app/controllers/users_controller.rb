class UsersController < ApplicationController

  before_action :authorization, only: [:signout, :update, :destroy, :show]

  def signin
    @user = find_user(user_params[:username], user_params[:email])
    if @user&.authenticate(user_params[:password])
      render json: { ok: true, data: user_token(@user) }
    else
      render json: { ok: false, err: 'Unauthorized' } 
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def signout
    @current_user = nil
  end

  def signup 
    @user = User.new(user_params)
    @user.save
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private 
  
  def find_user(username, email)
    @user = User.where("username = ? or email = ? ", username, email)
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :username, :password)
  end

  def user_token(user)
    { token: WebToken.encode({user_id: user.id}), exp: 24.hours.from_now.to_date.to_s, username: user.username }  
  end
end
