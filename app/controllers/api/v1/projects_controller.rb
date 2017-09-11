class Api::V1::ProjectsController < AuthenticationController
  
  before_action :authenticate
  
  def create
    project = @user.projects.build(project_params)
    
    if project.save
      render json: { project: project }, status: :created
    else
      render_bad_request(project)
    end
  end
  
  def update
    project = Project.where("id = ? AND user_id = ?", params[:id], @user[:id]).first
    
    if project && project.update_attributes(project_params)
      render json: { project: project }, status: :ok
    else
      render_bad_request(project)
    end
  end
  
  def destroy
    project = Project.where("id = ? AND user_id = ?", params[:id], @user[:id]).first
    
    if project && project.destroy
      render json: {}, status: :no_content
    else
      render_bad_request(project)
    end
  end
  
  private
    
    def project_params
      params.require(:project).permit(:name)
    end
  
    def render_bad_request(project = nil)
      response_body = {
        status: 'NG',
        code: 400,
        error: Rack::Utils::HTTP_STATUS_CODES[400],
      }
      response_body.merge!({ messages: project.errors.messages }) if project 
      render json: response_body, status: :bad_request
    end
end
