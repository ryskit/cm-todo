class Api::V1::UsersController < AuthenticationController

  before_action :authenticate, except: [:create]

  def create
    user = User.new(user_params)
    
    if user.save
      payload = { :uuid => user.uuid, :name => user.name }
      access_token = Token.create_access_token(payload) 
      refresh_token = user.refresh_tokens.create
        
      render json: {
        status: 'OK',
        access_token: access_token,
        refresh_token: refresh_token.token,
        refresh_token_exp: refresh_token.expiration_at.to_i,
      }, status: :created
    else
      render_bad_request(user)
    end
  end
  
  def update_account
    if @user.update_attributes(update_account_params) 
      render json: { user: @user }, status: :ok
    else
      render_bad_request(@user)
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def update_account_params
      params.require(:user).permit(:name, :email)
    end
  
    def update_password_params
      params.require(:user).permit(:old_password, :new_password, :password_confirmation)
    end
  
    def render_bad_request(user = nil)
      response_body = {
        status: 'NG',
        code: 400,
        error: Rack::Utils::HTTP_STATUS_CODES[400],
      }
      response_body = response_body.merge({ messages: user.errors.messages }) if user
      render json: response_body, status: :bad_request
    end
end
