class IpaappsController < ApplicationController
  before_action :set_ipaapp, only: [:show, :edit, :update, :destroy]

  # GET /ipaapps/1
  # GET /ipaapps/1.json
  def show
  end

  # GET /ipaapps/new
  def new
    @ipaapp = Ipaapp.new
    @project = actual_project
  end

  # GET /ipaapps/1/edit
  def edit
    @project = actual_project
  end

  # POST /ipaapps
  # POST /ipaapps.json
  def create
    @project = actual_project
    @ipaapp = Ipaapp.new(ipaapp_params)
    actual_project.ipaapps << @ipaapp
    respond_to do |format|
      if @ipaapp.save
        format.html { redirect_to actual_project }
        format.json { render 'show', status: :created, location: @ipaapp }
      else
        format.html { render 'new' }
        format.json { render json: @ipaapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ipaapps/1
  # PATCH/PUT /ipaapps/1.json
  def update
    respond_to do |format|
      if @ipaapp.update(ipaapp_params)
        format.html { redirect_to actual_project, notice: @ipaapp.name+t('application.updated') }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @ipaapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ipaapps/1
  # DELETE /ipaapps/1.json
  def destroy
    @ipaapp.destroy
    respond_to do |format|
      format.html { redirect_to actual_project }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ipaapp
      @ipaapp = actual_project.ipaapps.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ipaapp_params
      params[:ipaapp].permit(:name,:bundleID,:autonotification)
    end
end
