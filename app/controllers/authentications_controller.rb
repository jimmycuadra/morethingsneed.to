class AuthenticationsController < ApplicationController
  def create
    authentication = Authentication.from_omniauth(env["omniauth.auth"])
    session[:user_id] = authentication.user_id
    redirect_to root_path
  end
end
