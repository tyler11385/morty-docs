class ApplicationController < ActionController::API
    include JsonWebToken
  
    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
  
      decoded = JsonWebToken.decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render json: { errors: ['Unauthorized'] }, status: :unauthorized
    end
  
    def current_user
      @current_user
    end
  end
  