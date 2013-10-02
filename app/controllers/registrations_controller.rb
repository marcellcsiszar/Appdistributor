# app/controllers/sessions_controller.rb
class RegistrationsController < Devise::RegistrationsController
  # POST /resource/update
  def update
    super
    setup_cookie_organization
  end
end
