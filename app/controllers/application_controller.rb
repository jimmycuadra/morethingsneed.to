class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :add_current_user_to_js_data
  before_filter :add_persona_to_js_data

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def js_data
    @js_data ||= {}
  end
  helper_method :js_data

  def add_current_user_to_js_data
    js_data[:current_user] = current_user if current_user
  end

  def add_persona_to_js_data
    if current_user
      authentication = current_user.authentications.where(
        provider: "persona"
      ).first

      js_data[:persona_uid] = authentication.uid if authentication
    end
  end
end
