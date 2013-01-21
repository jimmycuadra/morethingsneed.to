class SessionsController < ApplicationController
  def create
    session[:user_id] = authentication.user_id

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { head :created }
    end
  rescue Authentication::PersonaAssertionError => e
    render text: e.message, status: :unauthorized
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def authentication
    @authentication ||= begin
      if env.key?("omniauth.auth")
        Authentication.from_omniauth(env["omniauth.auth"])
      else
        Authentication.from_persona(params[:assertion])
      end
    end
  end
end
