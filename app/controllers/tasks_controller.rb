class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks
  def index
    # Only fetch tasks for the logged in user
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  # GET /tasks/:id
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.new
  end

  # POST /tasks
  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /tasks/:id/edit
  def edit
  end

  # PATCH/PUT /tasks/:id
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted."
  end

  private

  def set_task
    # use current_user.tasks.find to enforce ownership at DB level
    @task = current_user.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tasks_path, alert: "Task not found or you don't have permission."
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed, :due_date)
  end
end
