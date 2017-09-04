class Api::V1::TasksController < AuthenticationController
  
  before_action :authenticate
  
  DEFAULT_PAGE_NUM = 1
  
  def index
    @tasks = search_tasks
    render json: { tasks: @tasks }, status: :ok
  end

  def show
    @task = Task.where("id = ? AND user_id = ?", params[:id], @user[:id])
    if @task
      render json: { task: @task }, status: :ok
    else
      render json: { 
        status: 'NG',
        code: 404,
        error: Rack::Utils::HTTP_STATUS_CODES[404]
      }, status: :not_found
    end
  end

  def create
    @task = @user.tasks.create(task_params)
    
    if @task.errors.empty?
      render json: { task: @task }, status: :ok
    else
      render json: {
        status: 'NG',
        code: 400,
        error: Rack::Utils::HTTP_STATUS_CODES[400],
        messages: @task.errors.messages
      }, status: :bad_request
    end
  end

  def update
    @task = Task.where("id = ? AND user_id = ?", params[:id], @user[:id]).first
    if @task.update_attributes(task_params)
      render json: { task: @task }, status: :ok
    else
      render json: {
        status: 'NG',
        code: 400,
        error: Rack::Utils::HTTP_STATUS_CODES[400],
        messages: @task.errors.messages
      }, status: :bad_request
    end
  end

  def destroy
    @task = Task.where("id = ? AND user_id = ?", params[:id], @user[:id]).first
    if @task.destroy
      render json: { status: :ok }, status: :ok
    else
      render json: {
        status: :ng,
        error: Rack::Utils::HTTP_STATUS_CODES[400],
        messages: @task.error.messages
      }, status: :bad_request
    end
  end

  private
    
    def task_params
      params.require(:task).permit(:title, :content, :due_to, :checked)
    end
  
    def search_tasks
      page_num = params[:page] || DEFAULT_PAGE_NUM
      Task
        .by_q(params[:q])
        .by_user_id(@user[:id])
        .by_title(params[:title])
        .by_content(params[:content])
        .by_checked(params[:checked])
        .by_next_days(params[:next_days])
        .by_checked(params[:expired])
        .order(:created_at)
        .page(page_num)
    end
end
