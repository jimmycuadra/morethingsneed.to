class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  helper_method :current_user, :is_admin
  before_filter :prepare_new_entry
   
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
  
  def require_no_user
    if current_user
      flash[:error] = 'That\'s only for guests, champ. Log out and try that again.'
      redirect_to root_path and return
    end
  end
end
