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
  
  
  describe 'POST#create' do

    let(:valid_task_params) { { task: attributes_for(:valid_task_params) } }
    let(:invalid_task_params) { { task: attributes_for(:invalid_task_params) } }

    describe 'アクセストークンが有効な場合' do
      
      context '有効なパラメータの場合' do
        it 'taskを新規作成' do
          controller.request.headers['Authorization'] = "Bearer #{@user_tokens[:access_token]}"
          controller.request.headers['CONTENT_TYPE'] = 'application/json'

          expect {
            post :create, params: valid_task_params
          }.to change(Task, :count).by(1)
          
          res_body = JSON.parse(response.body)
          expect(res_body['title']).to eq valid_task_params[:title]
          expect(res_body['content']).to eq valid_task_params[:content]
        end
      end

      context '無効なパラメータの場合' do
        it 'タイトルが空の場合はエラーとなる' do
          controller.request.headers['Authorization'] = "Bearer #{@user_tokens[:access_token]}"
          controller.request.headers['CONTENT_TYPE'] = 'application/json'

          post :create, params: invalid_task_params

          res_body = JSON.parse(response.body)
          expect(res_body['status']).to eq 'NG'
          expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[400]
          expect(res_body['messages'].present?).to be true
          expect(res_body['messages']['title'].present?).to be true
        end
      end
      
    end

    describe 'アクセストークンが無効な場合' do
      
      it 'タスクの新規作成がエラーになる' do
        controller.request.headers['Authorization'] = 'Bearer aaaaaaaaaaaaaaaaaaaaaaaaa'
        controller.request.headers['CONTENT_TYPE'] = 'application/json'
        post :create, params: valid_task_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
    
  end
end
