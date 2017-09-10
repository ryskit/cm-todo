class Api::V1::ProjectsController < AuthenticationController
  
  before_action :authenticate
  
  def create
    project = @user.projects.build(project_params)
    
    if project.save
      render json: { project: project }, status: :created
    else
      render json: {
        status: 'NG',
        code: 400,
        error: Rack::Utils::HTTP_STATUS_CODES[400],
        messages: project.errors.messages
      }, status: :bad_request
    end
  end
  
  def update
    project = Project.where("id = ? AND user_id = ?", params[:id], @user[:id]).first
    
    if project && project.update_attributes(project_params)
      render json: { project: project }, status: :ok
    else
      render json: {
        status: 'NG',
        code: 400,
        error: Rack::Utils::HTTP_STATUS_CODES[400],
        messages: project.errors.messages
      }, status: :bad_request
    end
  end

  private
    
    def project_params
      params.require(:project).permit(:name)
    end
end
