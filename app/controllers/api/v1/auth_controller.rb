class Api::V1::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorize_request
  def create
    email = params.dig(:auth, :email)
    password = params.dig(:auth, :password)
    user=User.find_by(email:email)
    if user && user.authenticate(password)
      token=generate_token(user)
      render json: {"token":token}
    else
      render json:{ error:"invalid email or password"}, status: :unauthorized
    end
  end

  private

  def generate_token(user)
    JWT.encode({user_id:user.id},Rails.application.secret_key_base)
  end
end
