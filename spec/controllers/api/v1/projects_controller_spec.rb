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
    describe 'アクセストークンが有効な場合' do

      let(:valid_params) { { project: attributes_for(:valid_params) } }
      
      context 'パラメータが有効な場合' do
        it 'プロジェクトを新規作成する' do
          expect do
            post :create, params: valid_params
          end.to change(Project, :count).by(1)
          expect(response).to have_http_status(:created)
          res_body = JSON.parse(response.body)
          puts res_body['project']['name']
          expect(res_body['project']['name']).to eq valid_params[:project][:name]
        end
      end
      
      context 'パラメータが無効な場合' do
      end
    end
    
    describe 'アクセストークンが無効な場合' do
    end
  end
  
  
end
