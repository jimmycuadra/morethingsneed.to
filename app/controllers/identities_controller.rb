class IdentitiesController < ApplicationController
  def login
  end

  def register
    @identity = env['omniauth.identity'] || Identity.new
  end
end
