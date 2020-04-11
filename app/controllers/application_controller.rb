class ApplicationController < ActionController::API

  rescue_from JWT::DecodeError do |err|
    render json: { ok: false, err: err }, status: 401
  end
  rescue_from ActiveRecord::RecordNotFound do |err| 
    render json: { ok: false, err: err },  status: 404
  end

  rescue_from ActiveRecord::RecordInvalid do |err|
    render json: { ok: false, err: err }, status: 400
  end

  def authorization
    token = request.headers['Authorization']
    WebToken.decode(token)
  end
end
