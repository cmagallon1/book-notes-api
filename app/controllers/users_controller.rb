class UsersController < ApplicationController
  before_action :authorization, except: :create
  before_action only: [:update, :destroy, :show] do 
    current_user(:id)
  end

  def create 
    @user = User.new(user_params)
    @user.save!
  end

  def update
    @current_user.update!(user_params)
  end

  def destroy
    @current_user.update_attribute(:disable, DateTime.now)
  end

  private 
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end
end
