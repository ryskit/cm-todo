require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  
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
  
  describe 'GET#index' do
    describe 'アクセストークンが有効な場合' do
      
      it 'タスクの一覧を取得する' do
        get :index, params: {}
        expect(response).to have_http_status(:ok)
        res_body = JSON.parse(response.body)
        # 現状50件まで
        expect(res_body['tasks'].size).not_to eq TASK_SIZE
      end
    end
    
    describe 'アクセストークンが無効な場合' do
      it 'unauthorized errorとなる' do
        controller.request.headers['Authorization'] = 'Bearer aaaaaaaaaaaaaaaaaaaaaaaaa'
        get :index, params: {}
        expect(response).to have_http_status(:unauthorized)
        
        res_body = JSON.parse(response.body)
        expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[401]
      end
    end
  end
  
  describe 'POST#create' do

    let(:valid_task_attributes) { { task: attributes_for(:valid_task_attributes) } }
    let(:invalid_task_attributes) { { task: attributes_for(:invalid_task_attributes) } }

    describe 'アクセストークンが有効な場合' do
      
      context '有効なパラメータの場合' do
        it 'タスクを新規作成' do
          expect {
            post :create, params: valid_task_attributes
          }.to change(Task, :count).by(1)
          
          res_body = JSON.parse(response.body)
          expect(res_body['title']).to eq valid_task_attributes[:title]
          expect(res_body['content']).to eq valid_task_attributes[:content]
        end
      end

      context '無効なパラメータの場合' do
        it 'タイトルが空の場合はエラーとなる' do
          post :create, params: invalid_task_attributes

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
        post :create, params: valid_task_attributes
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  
  
  describe 'PATCH#update' do
    
    let(:update_task_attributes) { attributes_for(:update_task_attributes) }
    let(:created_task) { @tasks.first }
    
    describe 'アクセストークンが有効な場合' do
      
      context '有効なパラメータの場合' do
        it 'タスクを更新する'do
          patch :update, params: { id: created_task['id'], task: update_task_attributes }
          
          res_body = JSON.parse(response.body)
          expect(res_body['task']['id']).to eq created_task['id']
          expect(res_body['task']['title']).not_to eq created_task['title']
          expect(res_body['task']['content']).not_to eq created_task['content']
          expect(res_body['task']['due_to']).to be >= created_task['due_to']
        end
      end
    end
    
    describe 'アクセストークンが無効な場合' do
      it 'unauthorized errorとなる' do
        controller.request.headers['Authorization'] = 'Bearer aaaaaaaaaaaaaaaaaaaaaaaaa'
        patch :update, params: { id: created_task['id'], task: update_task_attributes }
        expect(response).to have_http_status(:unauthorized)

        res_body = JSON.parse(response.body)
        expect(res_body['error']).to eq Rack::Utils::HTTP_STATUS_CODES[401]
      end
    end
  end
  
end
