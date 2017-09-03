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
        puts res_body
      end
    end

    context '無効なパラメータの場合' do
      
      let(:params) do
        {
          user: {
            name: 'ryskit',
            email: 'ryskit+@example.com',
            password: 'password',
            password_confirmation: 'password',
            uuid: 'f504ac63d55b6b0da66ef938ba5e38877c5105c329205e37d1822aa2bf3d44e8e28fb8586ea727b6b84fd06f4adbdf300ff5d23ec95a500a8310488c769ba5b1'
          }
        }
      end
      
      it 'パラメータが不正でユーザー登録に失敗する' do
        
      end
    end
    
  end
end
