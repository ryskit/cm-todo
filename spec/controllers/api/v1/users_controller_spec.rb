require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe 'POST#create' do
    
    context '有効なパラメータの場合' do
      
      let(:params) do
        {
          user: {
            name: 'ryskit',
            email: 'ryskit@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end
        
      it 'ユーザーを新規に登録する' do
        expect{
          post :create, params: params
        }.to change(User, :count).by(1)
        
        expect(response).to have_http_status(201)
        
        res_body = JSON.parse(response.body)
        expect(res_body['status']).to eq 'OK'
        expect(res_body['access_token'].present?).to be true
        expect(res_body['refresh_token'].present?).to be true
        expect(res_body['refresh_token_exp'].present?).to be true
      end
    end

    context '無効なパラメータの場合' do
      
      let(:params) do
        {
          user: {
            name: 'a' * 101,
            email: 'ryskit+@example.com',
            password: 'pass',
            password_confirmation: 'pass',
          }
        }
      end
      
      it 'パラメータが不正でユーザー登録に失敗する' do
        expect{
          post :create, params: params
        }.to change(User, :count).by(0)
        
        res_body = JSON.parse(response.body)
        expect(res_body['status']).to eq 'NG'
        expect(res_body['error'].present?).to be true
        expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[400]
        expect(res_body['messages']['name'].present?).to be true
        expect(res_body['messages']['email'].present?).to be true
        expect(res_body['messages']['password'].present?).to be true
      end
    end
    
  end
  
  describe 'PATCH#update' do
    
    before :each do
      @user = create(:user)
      payload = { :uuid => @user.uuid, :name => @user.name }
      access_token = Token.create_access_token(payload)
      refresh_token = @user.refresh_tokens.create

      @user_tokens = {
        access_token: access_token,
        refresh_token: refresh_token.token,
        refresh_token_exp: refresh_token.expiration_at.to_i,
      }
      
      controller.request.headers['Authorization'] = "Bearer #{@user_tokens[:access_token]}"
      controller.request.headers['CONTENT_TYPE'] = 'application/json'
    end
    
    context '有効なパラメータの場合' do
      
      it '名前を更新する' do
        expect do
          patch :update_account, params: { user: attributes_for(:updated_user_name) }
        end.to change(User, :count).by(0)
        expect(response).to have_http_status(:ok)
        res_body = JSON.parse(response.body)
        expect(res_body['user']['name']).not_to eq @user[:name]
      end
      
      it 'メールアドレスを更新する' do
        expect do
            patch :update_account, params: { user: attributes_for(:updated_user_email) }
        end.to change(User, :count).by(0)
        expect(response).to have_http_status(:ok)
        res_body = JSON.parse(response.body)
        expect(res_body['user']['email']).not_to eq @user[:email]
      end
      
    end
    
    context '無効なパラメータの場合' do
      it 'unauthorized errorとなる' do
        controller.request.headers['Authorization'] = 'Bearer aaaaaaaaaaaaaaaaaaaaaaaaa'
        patch :update_account, params: { user: attributes_for(:updated_user_email) }
        expect(response).to have_http_status(:unauthorized)

        res_body = JSON.parse(response.body)
        expect(res_body['status']).to eq 'NG'
        expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[401]
      end
    end
  end
end
