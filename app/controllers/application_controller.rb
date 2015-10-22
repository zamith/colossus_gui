require "api_connector"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def api
    ColossusBets::APIConnector.instance
  end

  def customer_id
    session[:customer_id] ||= SecureRandom.uuid
  end
end
