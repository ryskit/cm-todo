class Api::V1::TasksController < AuthenticationController
  
  before_action :authenticate
  
  DEFAULT_PAGE_NUM = 1
  DEFAULT_PER_PAGE = 50
  
  def index
    @tasks = search_tasks
    render json: { tasks: @tasks }, status: :ok
  end

  def show
    @task = Task.where('id = ? AND user_id = ?', params[:id], @user[:id])
    if @task && @task.present?
      render json: { task: @task }, status: :ok
    else
      render json: { 
        status: 'NG',
        code: 404,
        error: Rack::Utils::HTTP_STATUS_CODES[404]
      }, status: 404
    end
  end

  def create
    @task = @user.tasks.create(task_params)
    
    if @task.errors.empty?
      render json: { task: @task }, status: :ok
    else
      render_bad_request(@task)
    end
  end

  def update
    @task = Task.where("id = ? AND user_id = ?", params[:id], @user[:id]).first
    if @task && @task.update_attributes(task_params)
      render json: { task: @task }, status: 200
    else
      render_bad_request(@task)
    end
  end

  def destroy
    @task = Task.where("id = ? AND user_id = ?", params[:id], @user[:id]).first
    if @task && @task.destroy
      render json: {}, status: 204
    else
      render_bad_request(@task) 
    end
  end

  private
    
    def task_params
      params.require(:task).permit(:title, :content, :due_to, :checked)
    end
  
    def search_tasks
      page_num = params[:page] || DEFAULT_PAGE_NUM
      per_page = params[:per] || DEFAULT_PER_PAGE
      
      Task
        .by_q(params[:q])
        .by_user_id(@user[:id])
        .by_checked(params[:checked])
        .by_next_days(params[:next_days])
        .by_checked(params[:expired])
        .order(:created_at)
        .page(page_num)
        .per(per_page)
    end
  
    def render_bad_request(task = nil)
      response_body = {
        status: 'NG',
        code: 400,
        error: Rack::Utils::HTTP_STATUS_CODES[400],
      }
      response_body = response_body.merge({ messages: task.errors.messages }) if task
       render json: response_body, status: :bad_request     
    end
end
