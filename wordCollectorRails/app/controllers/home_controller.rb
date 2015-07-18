class HomeController < ApplicationController
  def show
    redirect_to categories_path if session[:user_id]
  end
end
