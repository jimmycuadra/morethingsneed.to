class UsersController < ApplicationController
  def new
  end
  
  def create
    @user = User.new(params[:user])
    @user.username = params[:user][:username]
    if @user.save
      flash[:notice] = 'Thanks for registering!'
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
      flash[:notice] = 'Your account details have been updated.'
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end
end