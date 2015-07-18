class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :check_user


  def check_user
    redirect_to home_show_path unless session[:user_id]
  end

  def current_user
    check_user # check_user has to be called before current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
