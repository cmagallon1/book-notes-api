class UsersController < ApplicationController
  before_action :authorization, except: :create
  before_action :find_user, only: [:update, :destroy, :show]

  def create 
    @user = User.new(user_params)
    @user.save!
  end

  def update
    @user.update!(user_params)
  end

  def destroy
    @user.update_attribute(:disable, DateTime.now)
  end

  private 
  
  def find_user
    @user = User.find_by!("id = ? and disable IS NULL", params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end
end
