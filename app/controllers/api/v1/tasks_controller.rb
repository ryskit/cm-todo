class Api::V1::TasksController < ApplicationController

  def index
    @tasks = Task.all
    render json: @tasks, except:[:user_id, :created_at, :updated_at]
  end

  def show
  end

  def create
    render json: params
  end

  def update
  end

  def delete
  end

end
