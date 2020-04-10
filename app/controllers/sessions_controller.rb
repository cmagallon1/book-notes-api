class SessionsController < ApplicationController
  around_action :catch_errors, only: :create

  def create
    @user = user
    if @user&.authenticate(user_params[:password])
      render json: { ok: true, data: user_token(@user) }
    else
      render json: { ok: false, err: 'Unauthorized' } 
    end
  end

  def destroy
    @current_user = nil
    unless @current_user
      render json: { ok: true, status: 200, data: 'signout successfully'}
    else 
      render json: { ok: false, status: 400, err: 'Something went wrong'}
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

  def catch_errors
    yield
  rescue ActiveRecord::RecordNotFound => err
    render json: { ok: false, status: 404, err: err}
  end
end
