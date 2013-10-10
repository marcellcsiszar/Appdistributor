class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  before_action :set_build, only: [:show, :index, :create, :new ]

  # GET /organizations
  # GET /organizations.json
  def index
  #binding.pry
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new

  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @notification = Notification.new(notification_params)
    respond_to do |format|
      if @organization.save
        format.html { redirect_to authenticated_user_root, notice: 'Notification(s) was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      if params.has_key?(:apkbuild_id)
      @notification = actual_project.apkapps.find(params[:apkapp_id]).apkbuilds.find(params[:apkbuild_id]).notifications.find(params[:id])
      elsif params.has_key?(:ipabuild_id)
      @notification = actual_project.ipaapps.find(params[:ipaapp_id]).ipabuilds.find(params[:ipabuild_id]).notifications.find(params[:id])
      end
    end

    def set_build
      if params.has_key?(:apkbuild_id)
      @build = actual_project.apkapps.find(params[:apkapp_id]).apkbuilds.find(params[:apkbuild_id])
      elsif params.has_key?(:ipabuild_id)
      @build = actual_project.ipaapps.find(params[:ipaapp_id]).ipabuilds.find(params[:ipabuild_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params[:notification].permit(:user_ids => [],:customer_ids => [])
    end
end
