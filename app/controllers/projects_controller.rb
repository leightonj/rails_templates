# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy event]

  # GET /projects
  def index
    @projects = Project.details.order(id: :desc)
  end

  # GET /projects/1
  def show; end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  def create
    @project = Project.new(project_params.merge(creator: User.first))

    if @project.save
      redirect_to @project, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: t(".success"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy!
    redirect_to projects_url, notice: t(".success"), status: :see_other
  end

  def event
    event = @project.aasm.events.find { |evt| evt == params["event"].to_sym }
    @project.send("#{event}!")
    redirect_back(fallback_location: project_path(@project))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.details.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    pars = params.require(:project).permit(:title, :description)
    pars[:title].strip!
    pars[:description].strip!
    pars
  end
end
