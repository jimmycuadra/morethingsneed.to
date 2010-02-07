class ActivationsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.reset_perishable_token!
      ActionMailer::Base.default_url_options[:host] = request.host
      Notifier.deliver_activation_instructions(@user)
      flash[:success] = 'Please check your e-mail for a new copy of your activation instructions.'
      redirect_to root_path
    else
      flash.now[:error] = 'Sure you got that e-mail address right? We don\'t have an account registered to it.'
      render :action => :new
    end
  end
  
  def activate
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise ActiveRecord::RecordNotFound)
    if @user.active?
      flash[:error] = 'Your account is already active.'
    else
      if @user.activate!
        @user.reset_perishable_token!
        UserSession.create(@user)
        flash[:success] = 'Your account is now activated.'
      else
        flash[:error] = 'Activation failed and this unhelpful error message was provided.'
      end
    end    
    redirect_to root_path
  end  
end
