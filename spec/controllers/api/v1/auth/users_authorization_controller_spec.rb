require 'rails_helper'

RSpec.describe Api::V1::Auth::UsersAuthorizationController, type: :controller do

  describe 'POST#authorize' do
    
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
    
    context '有効なパラメータの場合' do
      
      let(:user_params) do
        {
          user: {
            email: @user[:email],
            password: 'password'
          }
        }
      end
      
      it '認証を行う' do
        
        # 同じ時刻でaccess_tokenが再生成されないようにするため
        sleep(1)
        
        post :authorize, params: user_params
        expect(response).to have_http_status(:ok)
        
        res_body = JSON.parse(response.body)
        expect(res_body['access_token'].present?).to be true
        expect(res_body['access_token']).not_to eq @user_tokens[:access_token]
        
        expect(res_body['refresh_token'].present?).to be true
        expect(res_body['refresh_token']).not_to eq @user_tokens[:refresh_token]
        
        expect(res_body['refresh_token_exp'].present?).to be true
        expect(res_body['refresh_token_exp']).not_to eq @user_tokens[:refresh_token_exp]
      end
    end
    
    context '無効なパラメータの場合' do
      
      let(:user_params) do
        {
          user: {
            email: @user[:email],
            password: 'mispassword'
          }
        }
      end
      
      it '認証に失敗する' do
        
        # 同じ時刻でaccess_tokenが再生成されないようにするため
        sleep(1)
        
        post :authorize, params: user_params
        expect(response).to have_http_status(:unauthorized)
        
        res_body = JSON.parse(response.body)
        expect(res_body['status']).to eq 'NG'
        expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[401]
      end
    end

  end
  
end
