class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_organization, :available_organizations, :setup_cookie_organization

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :password, :email, :current_password,:organization_ids => []) }
  end

  def current_organization
    return cookies[:current_organization]
  end

  # Setup organization id in cookies. In session and navigation works too.
  def setup_cookie_organization
    cookies[:current_organization] = available_organizations.count>0 ? available_organizations.first._id : nil
  end

  def setup_cookie_organization(org_id)
    cookies[:current_organization] = org_id
  end

  def available_organizations
    return @available_organizations = Organization.where(:user_ids.in=>[current_user])
  end

end
