class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_build, only: [:show, :index, :create, :new ]

  # GET /organizations
  # GET /organizations.json
  def index
  @notifications = Notification.where(params.to_a.last(1)[0][0].to_sym=>Moped::BSON::ObjectId.from_string((params.to_a.last(1)[0][1])))
    @notifications.each do |notification|
      data = RestClient.get "https://api:key-54tjingsrxlx11cgh63mr6x-wqm48f02"\
    "@api.mailgun.net/v2/testdistributor.mailgun.org/events",
     :params => {
      :'message-id'  => notification.mailgun_message_id,
      :'limit'       =>  1,
      :'pretty'      => 'yes'
     }
     data = JSON.parse(data)
     if data["items"].any?
       case data["items"][0]["event"]
        when "delivered"
        when "opened"
          notification.read
        when "clicked"
          notification.clicked
        end
      end
    end
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
    notifications_params[:user_ids].uniq.each do |user_id|
      if user_id != ""
        case params.to_a.last(1)[0][0].first(3)
        when "apk"
          Notification.create(:user_id => user_id,:apkbuild_id => params[:apkbuild_id], :platform => "apk", :app_name => @build.apkapp.name, :downlink => "http://#{request.host}:#{request.port}#{@build.package.url}")
        when "ipa"
          Notification.create(:user_id => user_id,:ipabuild_id => params[:ipabuild_id], :platform => "ipa",:app_name => @build.ipaapp.name, :downlink => "http://#{request.host}:#{request.port}#{@build.plist.url}")
        else
        end
      end
    end
    redirect_to request.original_url[0..-2], notice: 'Notification(s) was successfully sended.'
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
