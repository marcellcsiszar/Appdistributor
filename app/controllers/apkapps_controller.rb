class ApkappsController < ApplicationController
  before_action :set_apkapp, only: [:show, :edit, :update, :destroy]

  # GET /apkapps/1
  # GET /apkapps/1.json
  def show
  end

  # GET /apkapps/new
  def new
    @apkapp = Apkapp.new
    @project = actual_project
  end

  # GET /apkapps/1/edit
  def edit
    @project = actual_project
  end

  # POST /apkapps
  # POST /apkapps.json
  def create
    @apkapp = Apkapp.new(apkapp_params)
    actual_project.apkapps << @apkapp
    respond_to do |format|
      if @apkapp.save
        format.html { redirect_to actual_project }
        format.json { render 'show', status: :created, location: @apkapp }
      else
        format.html { render 'new' }
        format.json { render json: @apkapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apkapps/1
  # PATCH/PUT /apkapps/1.json
  def update
    respond_to do |format|
      if @apkapp.update(apkapp_params)
        format.html { redirect_to actual_project, notice: @apkapp.name+t('application.updated') }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @apkapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apkapps/1
  # DELETE /apkapps/1.json
  def destroy
    @apkapp.destroy
    respond_to do |format|
      format.html { redirect_to actual_project }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apkapp
      @apkapp = actual_project.apkapps.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apkapp_params
      params[:apkapp].permit(:name,:bundleID,:autonotification)
    end
end
