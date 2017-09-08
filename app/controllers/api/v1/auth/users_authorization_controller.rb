class Api::V1::Auth::UsersAuthorizationController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  def authorize
    refresh_token = get_latest_refresh_token(user_params[:email])
    user = refresh_token.user if refresh_token
    return render_unauthorized unless user && user.authenticate(user_params[:password]) 
    
    refresh_token.update_attribute(:expiration_at, nil)
    access_token = create_access_token(user)
    new_refresh_token = user.refresh_tokens.create

    render json: {
      :token_type => 'bearer',
      :access_token => access_token,
      :refresh_token => new_refresh_token.token,
      :refresh_token_exp => new_refresh_token.expiration_at.to_i,
    }, status: :ok
  end
  
  def refresh_access_token
    user = get_authenticated_user
    return render_unauthorized unless user
    
    access_token = create_access_token(user)
    render json: {
      :token_type => 'bearer',
      :access_token => access_token,
    }, status: :ok
    
  end

  def revoke
    refresh_token = get_latest_refresh_token(user_params[:email])
    user = refresh_token.user if refresh_token
    return render_unauthorized unless user && user.authenticate(user_params[:password]) 
    
    refresh_token.update_attribute(:expiration_at, nil)
    render json: {}, status: :ok
  end
  
  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
    
    def get_latest_refresh_token(email)
      RefreshToken
        .joins(:user)
        .where("users.email = ? AND refresh_tokens.expiration_at IS NOT NULL", email)
        .order("refresh_tokens.expiration_at DESC")
        .first
    end

    def render_unauthorized
      render json: {
        status: 'NG',
        code: 401,
        error: Rack::Utils::HTTP_STATUS_CODES[401],
      }, status: :unauthorized
    end

    def get_authenticated_user
      authenticate_with_http_token do |refresh_token, options|
        return User
          .joins(:refresh_tokens)
          .where("refresh_tokens.expiration_at > ? AND refresh_tokens.token = ?", Time.now, refresh_token)
          .first
      end
    end

    def create_access_token(user)
      payload = {:uuid => user.uuid, :name => user.name}
      Token.create_access_token(payload)
    end
  
end
