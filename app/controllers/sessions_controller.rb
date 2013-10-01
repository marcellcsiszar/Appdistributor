# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    cookies[:current_organization] = Organization.where(:user_ids.in=>[current_user]).count>0 ? Organization.where(:user_ids.in=>[current_user]).first._id : nil
    super
  end

  # GET /resource/sign_out
  def destroy
    cookies.delete :current_organization
    super
  end
end