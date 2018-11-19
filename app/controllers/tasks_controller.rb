class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all.page(params[:page]).per(3)
  end
  
  def show
  end

  def new
    @task = Task.new
  end
  
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'タスク が正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク が登録されませんでした'
      render :new
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスク が正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク が正常に更新されませんでした'
      render :new
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  # Strong Parameter
  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:content,:status)
  end




end