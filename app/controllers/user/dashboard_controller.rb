class User::DashboardController < ApplicationController
	before_filter :authenticate_user!
  def index
  	#Checking Getting Started page
    if current_user.organization_ids.empty? then
      redirect_to edit_user_registration_path
    end

  end

end
