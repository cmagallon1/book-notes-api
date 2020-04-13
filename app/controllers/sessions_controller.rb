class SessionsController < ApplicationController
  def create
    @user = user
    unless @user&.authenticate(user_params[:password])
      render json: { ok: false, err: 'Unauthorized' }, status: 401
    end
  end

  def destroy
    @current_user = nil
    unless @current_user 
      render json: { ok: true, data: 'Loggout successfully' }
    else 
      render json: { ok: true, data: 'Error trying to logout' }, status: 400
    end 
  end

  private

  def user
    User.find_by!('username = ? OR email = ? AND disable IS NULL', user_params[:username], user_params[:email])
  end
  
  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :username, :password)
  end
end
