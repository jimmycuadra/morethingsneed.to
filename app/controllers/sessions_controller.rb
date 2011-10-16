class SessionsController < ApplicationController
  def create
    login! User.find_or_create_via_auth_hash(request.env["omniauth.auth"])
  end

  def failure
    redirect_to :root, notice: "Authentication failed."
  end
end
