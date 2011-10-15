class SessionsController < ApplicationController
  def create
    login! User.authenticate(ENV["omniauth.auth"])
  end
end
