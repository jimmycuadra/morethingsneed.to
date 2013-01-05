class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def login(user)
    session[:user_id] = user.id
  end
end
