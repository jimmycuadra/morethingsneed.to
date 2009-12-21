class UserSessionsController < ApplicationController
  def new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = 'You are now logged in.'
      redirect_to root_path
    else
      flash.now[:error] = 'You fucked up.'
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:success] = 'You are now logged out.'
    redirect_to root_path
  end
end