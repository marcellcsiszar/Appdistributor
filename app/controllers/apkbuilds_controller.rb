class ApkbuildsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_apkapp, only: [:new, :create]
  # GET /builds/new
  def new
    @apkbuild = @apkapp.apkbuilds.build
  end

  # POST /builds
  # POST /builds.json
  def create
    @apkbuild = @apkapp.apkbuilds.build(apkbuild_params)
    @apkbuild.apk_process
    respond_to do |format|
      if @apkbuild.save
        format.html { redirect_to project_apkapp_path(:id => @apkbuild._parent._id), notice: 'Build was successfully created.' }
        format.json { render action: 'show', status: :created, location: @apkbuild }
      else
        flash[:error] = "Bad extension or BundleID"
        format.html { render 'new' }
        format.json { render json: @apkbuild.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def apkbuild_params
    params[:apkbuild].permit(:package,:package_uid,:project_id,:apkapp_id)
  end

  def set_apkapp
      @apkapp = actual_project.apkapps.find(params[:apkapp_id])
  end

end
