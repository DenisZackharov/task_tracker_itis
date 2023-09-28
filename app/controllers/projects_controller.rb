class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all.order(:id)
  end

  def show; end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: "Update Successful"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path, notice: "Created Successful"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @project.tasks.destroy_all # Delete associated tasks
    @project.destroy
    redirect_to projects_path, notice: "Project and associated tasks destroyed"
  end


  private

  def set_project
    @project = Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, tasks_attributes: [:name, :description, :deadline])
  end

end
