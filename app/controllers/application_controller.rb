class ApplicationController < ActionController::Base
  protect_from_forgery

  def login!(user)
    session[:user_id] = user.id
    redirect_to :root, notice: "You are now logged in."
  end

  def logout!
    session[:user_id] = nil
    redirect_to :root, notice: "You are now logged out."
  end

  def logged_in?
    !!session[:user_id]
  end
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end
  helper_method :current_user
end
