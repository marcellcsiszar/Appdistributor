# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    setup_cookie_organization
    super
  end

  # GET /resource/sign_out
  def destroy
    cookies.delete :current_organization
    super
  end
end