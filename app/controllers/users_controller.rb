class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]

  def index
    @users = User.where(:active => true).paginate(:page => params[:page], :per_page => User.per_page)
  end

  def new
  end

  def create
    username = params[:user].delete(:username)
    @user = User.new(params[:user])
    @user.username = username
    if @user.save_without_session_maintenance
      @user.reset_perishable_token!
      ActionMailer::Base.default_url_options[:host] = request.host
      NotificationMailer.activation_instructions(@user).deliver
      flash[:success] = 'Your account has been registered but is not yet active. Please check your e-mail for activation instructions.'
      redirect_to root_path
    else
      flash.now[:error] = 'You fucked up.'
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
      flash.now[:error] = 'You fucked up.'
      render :action => 'edit'
    end
  end
end
