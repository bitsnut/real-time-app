class ApplicationController < ActionController::Base
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_time_zone
  
  def go_back
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  private

  def set_time_zone
    client_time_zone = cookies["jstz_time_zone"]
    if client_time_zone.present?
      Time.zone = client_time_zone
    else
      Time.zone
    end
  end

end
