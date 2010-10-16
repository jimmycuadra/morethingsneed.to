class PasswordResetsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  
  def new
  end
  
  def edit
  end

  def create
     @user = User.find_by_email(params[:email]) 
     if @user
       @user.reset_perishable_token!
       ActionMailer::Base.default_url_options[:host] = request.host
       NotificationMailer.password_reset_instructions(@user).deliver
       flash[:success] = 'Check your e-mail for a link to reset your password.'
       redirect_to root_path
     else
       flash.now[:error] = 'Sure you got that e-mail address right? We don\'t have an account registered to it.'
       render :action => :new
     end
  end
  
  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if !@user.password.blank? && @user.save
      flash[:success] = 'Your password has been reset.'
      redirect_to root_path
    else
      flash.now[:error] = 'You must enter and confirm a valid new password.'
      render :action => :edit
    end
  end
  
  private
  
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = 'Stop trying to haxor us. That\'s not a valid token.'
      redirect_to root_path
    end
  end
end
