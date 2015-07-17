class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery with: :exception
  # http_basic_authenticate_with name: ENV['TEST_USER'], password: ENV['TEST_PASS'] 
  # skip_before_filter  :verify_authenticity_token


  # # from devise tutorial https://github.com/plataformatec/devise
  # before_action :authenticate_user!

  # from another devise tutorial https://github.com/danweller18/devise/wiki/Adding-a-Username-to-the-User-&-Admin-model
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:username, :email, :password, :password_confirmation, :current_password)}
  end
end
