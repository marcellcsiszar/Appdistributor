class Admin::DashboardController < ApplicationController
	before_filter :authenticate_admin!
  def index
  	#Checking Getting Started page
  	if current_user.last_sign_in_at.nil? then
  		redirect_to :controller => :DashboardController, :action => :welcome
	end
  end
end
