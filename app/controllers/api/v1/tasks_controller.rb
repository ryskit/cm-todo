class Api::V1::TasksController < AuthenticationController
  
  before_action :authenticate
  
  def index
    @tasks = Task.all
    render json: @tasks, except:[:user_id, :created_at, :updated_at]
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
  
end
