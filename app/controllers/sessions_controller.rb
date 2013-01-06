class SessionsController < ApplicationController
  def new
  end

  def create
    authentication = Authentication.from_omniauth(env["omniauth.auth"])
    session[:user_id] = authentication.user_id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
