class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorize_request
  wrap_parameters :user, include: [:username, :password,:email,:lastName,:firstName,:country]

  def create
    user = User.new(user_params)
    if user.save
      render json: {
        "data": {
            "id": user.id,
            "type": "users",
            "attributes": {
                "email": user.email,
                "name": "#{user.firstName} #{user.lastName}",
                "country": user.country,
                "createdAt": user.created_at,
                "updatedAt": user.updated_at
            }
        }
    }, status: :created
    else
      render json: { error: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstName, :lastName, :email, :password, :country)
  end
end
