class ApplicationController < ActionController::API
  def authorization
    token = request.headers['Authorization']
    begin
      WebToken.decode(token)
    rescue ActiveRecord::RecordNotFound => e
      render json: { ok: false, status: 'Unauthorized', err: e }
    rescue JWT::DecodeError => e
      render json: { ok: false, status: 'Unauthorized', err: e }
    end
  end
end
