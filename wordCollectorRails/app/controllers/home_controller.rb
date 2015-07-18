class HomeController < ApplicationController
  def show
    redirect_to root_path if session[:user_id]
  end
end
