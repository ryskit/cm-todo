class Api::V1::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    
    if @user.save
      payload = {:uuid => @user.uuid, :name => @user.name}
      access_token = Token.create_access_token(payload) 
      
      @user.refresh_tokens.create
      refresh_token = @user.refresh_tokens[0]
        
      render json: {
        :access_token => access_token,
        :refresh_token => refresh_token.token,
        :refresh_token_exp => refresh_token.expiration,
      }
    else
      render json: @user.errors.messages, status: :bad_request
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
