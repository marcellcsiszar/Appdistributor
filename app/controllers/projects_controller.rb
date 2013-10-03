class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json

  def index
    @projects =  actual_organization.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project =  actual_organization.projects.find(params[:id])
  end

  # GET /projects/new
  def new
    @organization = actual_organization
    @project = Project.new
    @customers = @organization.customers
    @users = @organization.users
  end

  # GET /projects/1/edit
  def edit
    @organization = actual_organization
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    actual_organization.projects << @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = actual_organization.projects.find(params[:id])
    end

    # Returns the actual organization
    def actual_organization
      return Organization.find(current_organization)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params[:project].permit(:bundleID,:name,:user_ids => [],:customer_ids => [])
    end

end
