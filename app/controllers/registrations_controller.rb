# app/controllers/sessions_controller.rb
class RegistrationsController < Devise::RegistrationsController
  # POST /resource/update
  def update
    super
    cookies[:current_organization] = Organization.where(:user_ids.in=>[current_user]).count>0 ? Organization.where(:user_ids.in=>[current_user]).first._id : nil
  end
end
