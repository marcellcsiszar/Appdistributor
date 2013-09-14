class User::DashboardController < ApplicationController
	before_filter :authenticate_user!
  def index
  	#Checking Getting Started page
  	if current_user.last_sign_in_at.nil? then
  		redirect_to :controller => :DashboardController, :action => :welcome
	end
  end

  def welcome

  end

end
