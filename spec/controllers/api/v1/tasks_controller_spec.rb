require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do

  before :each do
    @user = create(:user_params)
    payload = { :uuid => @user.uuid, :name => @user.name }
    access_token = Token.create_access_token(payload)
    refresh_token = @user.refresh_tokens.create

    @user_tokens = {
      access_token: access_token,
      refresh_token: refresh_token.token,
      refresh_token_exp: refresh_token.expiration_at.to_i,
    }
  end
  
end
