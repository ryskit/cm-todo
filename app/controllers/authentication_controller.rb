class AuthenticationController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  protected
  
    def authenticate
      @decode_access_token = authenticate_access_token
      return render_unauthorized unless @decode_access_token
      @user = User.find_by(uuid: @decode_access_token['uuid']) if @decode_access_token
    end
    
    def authenticate_access_token
      authenticate_with_http_token do |token, options|
        @decode_access_token = Token.decode_access_token(token)
      end
    end

    def render_unauthorized
      render json: {
        status: 'NG',
        code: 401,
        error: Rack::Utils::HTTP_STATUS_CODES[401]
      }, status: :unauthorized
    end
end