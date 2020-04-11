class SessionsController < ApplicationController

  def create
    @user = user
    if @user&.authenticate(user_params[:password])
      render json: { ok: true, data: user_token(@user) }
    else
      render json: { ok: false, err: 'Unauthorized' }, status: 401
    end
  end

  private

  def user
    User.find_by!('username = ? OR email = ? AND disable IS NULL', user_params[:username], user_params[:email])
  end
  
  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :username, :password)
  end

  def user_token(user)
    { token: WebToken.encode({user_id: user.id}), exp: 24.hours.from_now.to_date.to_s, username: user.username }  
  end
end
