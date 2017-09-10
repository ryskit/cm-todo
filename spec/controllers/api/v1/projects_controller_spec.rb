require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  TASK_SIZE = 51

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
    
    
    @tasks = []
    TASK_SIZE.times{
      task = @user.tasks.create(attributes_for(:update_task_attributes))
      @tasks.push(task)
    }

    controller.request.headers['Authorization'] = "Bearer #{@user_tokens[:access_token]}"
    controller.request.headers['CONTENT_TYPE'] = 'application/json'
  end
  
  describe 'POST#create' do

    let(:valid_params) { { project: attributes_for(:valid_params) } }
    let(:invalid_params) { { project: attributes_for(:invalid_params) } }
    
    describe 'アクセストークンが有効な場合' do
      context 'パラメータが有効な場合' do
        it 'プロジェクトを新規作成する' do
          expect do
            post :create, params: valid_params
          end.to change(Project, :count).by(1)
          expect(response).to have_http_status(:created)
          res_body = JSON.parse(response.body)
          expect(res_body['project']['name']).to eq valid_params[:project][:name]
        end
      end
      
      context 'パラメータが無効な場合' do
        it 'プロジェクト名が51文字以上でエラーとなる' do
          expect do
            post :create, params: invalid_params
          end.to change(Project, :count).by(0)
          expect(response).to have_http_status(:bad_request)
          res_body = JSON.parse(response.body)
          expect(res_body['status']).to eq 'NG'
          expect(res_body['code']).to eq 400
          expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[400]
          expect(res_body['messages']['name'].present?).to be true
        end
      end
    end
    
    describe 'アクセストークンが無効な場合' do
      it 'unauthorized errorとなる' do
        controller.request.headers['Authorization'] = "Bearer aaaaa"
        expect do
          post :create, params: valid_params
        end.to change(Project, :count).by(0)
        expect(response).to have_http_status(:unauthorized)
        res_body = JSON.parse(response.body)
        expect(res_body['status']).to eq 'NG'
        expect(res_body['code']).to eq 401
        expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[401]
      end
    end
  end
  
  
  describe 'PATCH#update' do
    
    before :each do
      @project = @user.projects.create(attributes_for(:valid_params))
    end

    let(:valid_params) { { project: attributes_for(:valid_update_params) } }
    let(:invalid_params) { { project: attributes_for(:invalid_params) } }
    
    describe 'アクセストークンが有効な場合' do
      context 'パラメータが有効な場合' do
        it 'プロジェクトを更新する' do
          expect do
            patch :update, params: valid_params.merge({ id: @project[:id] })
          end.to change(Project, :count).by(0)
          expect(response).to have_http_status(:ok)
          res_body = JSON.parse(response.body)
          expect(res_body['project']['name']).not_to eq @project[:name]
        end
      end
      
      context 'パラメータが無効な場合' do
        it 'プロジェクト名が51文字以上でエラーとなる' do
          expect do
            patch :update, params: invalid_params.merge({ id: @project[:id] })
          end.to change(Project, :count).by(0)
          expect(response).to have_http_status(:bad_request)
          res_body = JSON.parse(response.body)
          expect(res_body['status']).to eq 'NG'
          expect(res_body['code']).to eq 400
          expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[400]
          expect(res_body['messages']['name'].present?).to be true
        end
      end
    end
    
    describe 'アクセストークンが無効な場合' do
      it 'unauthorized errorとなる' do
        controller.request.headers['Authorization'] = "Bearer aaaaa"
        expect do
          patch :update, params: valid_params.merge({ id: @project[:id] })
        end.to change(Project, :count).by(0)
        expect(response).to have_http_status(:unauthorized)
        res_body = JSON.parse(response.body)
        expect(res_body['status']).to eq 'NG'
        expect(res_body['code']).to eq 401
        expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[401]
      end
    end
  end
end
