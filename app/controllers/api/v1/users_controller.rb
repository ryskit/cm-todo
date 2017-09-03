class Api::V1::UsersController < AuthenticationController

  before_action :authenticate, except: [:create]

  def create
    user = User.new(user_params)
    
    if user.save
      payload = {:uuid => user.uuid, :name => user.name}
      access_token = Token.create_access_token(payload) 
      refresh_token = user.refresh_tokens.create
        
      render json: {
        status: 'OK',
        access_token: access_token,
        refresh_token: refresh_token.token,
        refresh_token_exp: refresh_token.expiration_at.to_i,
      }, status: 201
    else
      render json: {
        status: 'NG',
        error: Rack::Utils::HTTP_STATUS_CODES[400],
        messages: user.errors.messages
      }, status: :bad_request
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
