class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :add_cors_headers

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  def add_cors_headers
    origin = request.headers["Origin"]
    unless (not origin.nil?) and (origin == "http://localhost" or origin.starts_with? "http://localhost:")
      origin = "https://your.production-site.org"
    end
    headers['Access-Control-Allow-Origin'] = origin
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
    allow_headers = request.headers["Access-Control-Request-Headers"]
    if allow_headers.nil?
      #shouldn't happen, but better be safe
      allow_headers = 'Origin, Authorization, Accept, Content-Type'
    end
    headers['Access-Control-Allow-Headers'] = allow_headers
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Max-Age'] = '1728000'
  end
end
