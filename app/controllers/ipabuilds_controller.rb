class IpabuildsController < ApplicationController
  before_filter :authenticate_user!


  # GET /builds/new
  def new
    @ipabuild = actual_organization.projects.find(actual_project).ipaapps.find(params[:ipaapp_id]).ipabuilds.build
  end

  # POST /builds
  # POST /builds.json
  def create
    @ipabuild = actual_organization.projects.find(actual_project).ipaapps.find(params[:ipaapp_id]).ipabuilds.build(ipabuild_params)
    @ipabuild.ipa_process
    respond_to do |format|
      if @ipabuild.save
        @url = "http://"+request.host+@ipabuild.package.url
        @ipabuild.generate_plist(@url)
        @ipabuild.save
        format.html { redirect_to project_ipaapp_path(:id => @ipabuild._parent._id), notice: 'Build was successfully created.' }
        format.json { render 'show', status: :created, location: @ipabuild }
      else
        flash[:error] = "Bad extension or BundleID"
        format.html { render 'new' }
        format.json { render json: @ipabuild.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def ipabuild_params
    params[:ipabuild].permit(:package,:package_uid,:project_id,:ipaapp_id)
  end

end
