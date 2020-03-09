class ApplicationController < ActionController::API
  def authorization
    token = request.headers['Authorization']
    begin
      decoded = WebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { ok: false, status: 'Unauthorized', err: e }
    rescue JWT::DecodeError => e
      render json: { ok: false, status: 'Unauthorized', err: e }
    end
  end
end
