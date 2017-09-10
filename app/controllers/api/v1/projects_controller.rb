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
        error: Rake::Utils::HTTP_STATUS_CODES[400],
        messages: project.errors.messages
      }, status: :bad_request
    end
  end

  private
    
    def project_params
      params.require(:project).permit(:name)
    end
end
