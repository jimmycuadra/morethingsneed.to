class AuthenticationsController < ApplicationController
  def create
    authentication = Authentication.find_or_create_via_omniauth(env["omniauth.auth"])
    login(authentication.user)
    redirect_to root_path
  end
end
