class UsersController < ApplicationController
  def new
  end
  
  def create
    @user = User.new(params[:user])
    @user.username = params[:user][:username]
    if @user.save_without_session_maintenance
      @user.reset_perishable_token!
      ActionMailer::Base.default_url_options[:host] = request.host
      Notifier.deliver_activation_instructions(@user)
      flash[:success] = 'Your account has been registered but is not yet active. Please check your e-mail for activation instructions.'
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = 'Your account details have been updated.'
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end
end