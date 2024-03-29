class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # protect_from_forgery with: :exception
  # skip_before_filter :verify_authenticity_token

  protected

  def after_sign_in_path_for(resource)
    request.env['omniauth-origin'] || appointments_path || root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :phone])
  end
end
