class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  helper_method :current_user, :is_admin
  before_filter :prepare_new_entry
  #has_mobile_fu
  #before_filter :layout is_mobile_device? ? "application_mobile" : "application"
   
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def is_admin
    return @is_admin if defined?(@is_admin)
    cu = current_user
    @is_admin = cu.nil? ? false : cu.admin
  end

  def prepare_new_entry
    @new_entry = Entry.new
  end
end
