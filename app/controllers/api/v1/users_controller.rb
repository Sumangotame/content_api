class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  wrap_parameters :user, include: [:username, :password,:email,:lastName,:firstName,:country]
  def signup
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { error: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstName, :lastName, :email, :password, :country)
  end
end
