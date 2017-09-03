class Api::V1::Auth::UsersAuthorizationController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  def authorize
    refresh_token = RefreshToken
      .joins(:user)
      .where("users.email = ? AND refresh_tokens.expiration_at IS NOT NULL", user_params[:email])
      .order("refresh_tokens.expiration_at DESC")
      .first

    user = refresh_token.user

    if user && user.authenticate(user_params[:password])

      if refresh_token.update_attribute(:expiration_at, nil)
        access_token = create_access_token user
        new_refresh_token = user.refresh_tokens.create

        render json: {
          :token_type => 'bearer',
          :access_token => access_token,
          :refresh_token => new_refresh_token.token,
          :refresh_token_exp => new_refresh_token.expiration_at.to_i,
        }, status: :ok
      end
    else
      render json: {
        status: 'NG',
        error: Rack::Utils::HTTP_STATUS_CODES[401],
      }, status: :unauthorized
    end
  end
  
  def refresh_access_token
    authenticate_with_http_token do |token, options|
      @user = authenticate_refresh_token?(token)
    end
    
    if @user
      payload = { :uuid => @user.uuid, :name => @user.name }
      access_token = Token.create_access_token(payload)
      render json: {
        :token_type => 'bearer',
        :access_token => access_token,
      }, status: :ok
    else
      render json: {
        status: 'NG',
        error: Rack::Utils::HTTP_STATUS_CODES[401]
      }, status: :unauthorized
    end
  end

  def revoke
    refresh_token = RefreshToken
      .joins(:user)
      .where("users.email = ? AND refresh_tokens.expiration_at IS NOT NULL", user_params[:email])
      .order("refresh_tokens.expiration_at DESC")
      .first
    
    user = refresh_token.user
    
    if user && user.authenticate(user_params[:password])
      
      if refresh_token.update_attribute(:expiration_at, nil)
        access_token = create_access_token user
        new_refresh_token = user.refresh_tokens.create

        render json: {
          :token_type => 'bearer',
          :access_token => access_token,
          :refresh_token => new_refresh_token.token,
          :refresh_token_exp => new_refresh_token.expiration_at.to_i,
        }, status: :ok
      end
    else
      render json: {
        status: 'NG',
        error: Rack::Utils::HTTP_STATUS_CODES[401],
      }, status: :unauthorized
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
  
    def create_access_token(user)
      payload = {:uuid => user.uuid, :name => user.name}
      Token.create_access_token(payload)
    end
    
    def authenticate_refresh_token?(refresh_token)
      User.joins(:refresh_tokens)
          .where("refresh_tokens.expiration_at > ? AND refresh_tokens.token = ?",
               Time.now, refresh_token).first
    end
end
