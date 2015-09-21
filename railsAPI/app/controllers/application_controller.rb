class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include Authenticable


  # CORS work around

  def cors_preflight_check # OPTIONS /(any-path)
    # headers["Access-Control-Allow-Origin"]  = CORS_CONFIG["origin"]
    headers["Access-Control-Allow-Origin"]  = "*"
    headers["Access-Control-Allow-Methods"] = CORS_CONFIG["methods"].join(",")
    headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept"
    head :ok
  end

  after_filter :cors_set_access_control_headers
  def cors_set_access_control_headers
    # headers["Access-Control-Allow-Origin"] = CORS_CONFIG["origin"]
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Method"] = request.method
  end

end
