class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = @project.tasks.all
  end

  def show; end

  def new
    @task = @project.tasks.build
  end

  def create
    @task = @project.tasks.build(task_params)

    if @task.save
      redirect_to project_tasks_path(@project), notice: 'Created Successful'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_tasks_path(@project), notice: "task destroyed"
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to project_tasks_path(@project), notice: "Update Successful"
     else
      render :edit, status: :unprocessable_entity
     end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end


  def task_params
    params.require(:task).permit(:name, :description, :status, :deadline)
  end
end
