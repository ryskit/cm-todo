class Api::V1::TasksController < AuthenticationController
  
  before_action :authenticate
  
  DEFAULT_PAGE_NUM = 1
  
  def index
    # @tasks = Task.where("user_id = ? AND checked = ?", @user[:id], false)
    #               .order(:created_at)
    #               .page(page_num)
    @tasks = search_tasks
    render json: @tasks
  end

  def show
    @task = Task.where("id = ? AND user_id = ?", params[:id], @user[:id])
    render json: @task, except: [:user_id]
  end

  def create
    @task = @user.tasks.create(task_params)
    
    if @task.errors.empty?
      render json: @task, only: [:title, :content]
    else
      render json: {
        status: 'error',
        error: 'invalid request',
        messages: @task.errors.messages
      }, status: :bad_request
    end
  end

  def update
    @task = Task.where("id = ? AND user_id = ?", params[:id], @user[:id]).first
    if @task.update_attributes(task_params)
      render json: @task, except: [:user_id]
    else
      render json: {
        status: 'bad request',
        error: 'invalid request',
        messages: @task.errors.messages
      }, status: :bad_request
    end
  end

  def destroy
    @task = Task.where("id = ? AND user_id = ?", params[:id], @user[:id]).first
    if @task.destroy
      render json: @task, except: [:user_id]
    else
      render json: {
        status: 'error',
        error: 'invalid request',
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
        .q(params[:q])
        .user_id(@user[:id])
        .title(params[:title])
        .content(params[:content])
        .checked(params[:checked])
        .next_days(params[:next_days])
        .checked(params[:expired])
        .order(:created_at)
        .page(page_num)
    end
end
