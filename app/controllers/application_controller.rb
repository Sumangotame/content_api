class ApplicationController < ActionController::Base
    before_action :authorize_request


    private

    def authorize_request
      header=request.headers['Authorization']
      token=header.split(' ').last if header.present?
      begin
        @decoded= JWT.decode(token, Rails.application.secret_key_base)
        @current_user=User.find(@decoded[0]['user_id'])
      rescue JWT::DecodeError
        render json:{error: 'invalid token'},status: :unauthorized
      end
    end
end
