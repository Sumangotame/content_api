class Api::V1::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorize_request

  def create
    user=User.find_by(email:sign_in_params[:email])
    if user && user.authenticate(sign_in_params[:password])
      token=generate_token(user)
      render json: {
        "data": {
          "id": user.id,
          "type": "users",
          "attributes": {
            "token": token,
            "email": user.email,
            "name": "#{user.firstName} #{user.lastName}",
            "country": user.country,
            "createdAt": user.created_at,
            "updatedAt": user.updated_at
          }
        }
      },status: :ok
    else
      render json:{ error:"invalid email or password"}, status: :unauthorized
    end
  end

  private

  def sign_in_params
    params.require(:auth).permit(:email,:password)
  end

  def generate_token(user)
    JWT.encode({user_id:user.id},Rails.application.secret_key_base)
  end
end
