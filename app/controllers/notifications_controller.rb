class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_build, only: [:show, :index, :create, :new ]

  # GET /organizations
  # GET /organizations.json
  def index
  #binding.pry
  end

  # GET /organizations/new
  def new
    @notifications = []
    @customers = Customer.find(actual_project.customer_ids)
    @organization = actual_organization
  end

  # POST /organizations
  # POST /organizations.json
  def create
    binding.pry
    notifications_params[:user_ids].uniq.each do |user_id|
      if user_id != ""
        case params.to_a.last(1)[0][0].first(3)
        when "apk"
          Notification.create(:user_id => user_id,:apkbuild_id => params[:apkbuild_id])
        when "ipa"
          Notification.create(:user_id => user_id,:ipabuild_id => params[:ipabuild_id])
        else
        end
      end
    end
    redirect_to request.original_url, notice: 'Notification(s) was successfully sended.'
  end

  private
    def set_build
      case params.to_a.last(1)[0][0].first(3)
      when "apk"
      @build = actual_project.apkapps.find(params[:apkapp_id]).apkbuilds.find(params[:apkbuild_id])
      when "ipa"
      @build = actual_project.ipaapps.find(params[:ipaapp_id]).ipabuilds.find(params[:ipabuild_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notifications_params
      params[:notifications].permit(:user_ids => [])
    end
end
