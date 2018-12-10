class TasksController < ApplicationController
  before_action :require_user_logged_in,only: [:show, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page]).per(3)
    end
  end
  
  def show

  end

  def new
    if logged_in?
    @task = current_user.tasks.new
    end
  end
  
  
  def create
    @task = current_user.tasks.build(task_params)
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
    if logged_in?
      if @task.update(task_params)
        flash[:success] = 'タスク が正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = 'タスク が正常に更新されませんでした'
        render :new
      end
    end
  end

  def destroy
    if logged_in?
      @task.destroy

      flash[:success] = 'タスク は正常に削除されました'
      redirect_to tasks_url
    end
  end
  
  private
  # Strong Parameter
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to root_url if !@task
  end

  def task_params
    params.require(:task).permit(:content,:status)
  end
end