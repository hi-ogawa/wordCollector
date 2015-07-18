class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # http_basic_authenticate_with name: ENV['TEST_USER'], password: ENV['TEST_PASS'] 
  # skip_before_filter  :verify_authenticity_token

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
