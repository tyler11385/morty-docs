class Api::AuthController < ApplicationController
  before_action :authorize_request, only: [:me]

  def signup
    company = Company.create!(name: params[:company_name], terms_accepted: true)
    user = company.users.build(user_params.merge(role: "editor"))

    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
  
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  
  def me
    render json: @current_user
  end

  private

  def user_params
    params.permit(:email, :password, :first_name, :last_name)
  end
end
