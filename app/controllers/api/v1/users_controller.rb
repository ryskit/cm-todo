class Api::V1::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    
    if @user.save
      payload = {:uuid => @user.uuid, :name => @user.name}
      access_token = JsonWebToken.create_access_token(payload) 
      render json: {:access_token => access_token}
    else
      render json: @user.errors.messages, status: :bad_request
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
