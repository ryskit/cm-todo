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
end
