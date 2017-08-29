class AuthenticationController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  protected
  
    def authenticate
      @decode_access_token = authenticate_access_token
      respond_unauthorized unless @decode_access_token
      @user = User.find_by(uuid: @decode_access_token['uuid'])
    end
    
    def authenticate_access_token
      authenticate_with_http_token do |token, options|
        @decode_access_token = Token.decode_access_token(token)
      end
    end

    def respond_unauthorized
      render json: {
        status: 'unauthorized',
        error: 'unauthorized_client'
      }, status: :unauthorized
    end
end