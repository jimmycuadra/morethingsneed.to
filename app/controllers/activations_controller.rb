class ActivationsController < ApplicationController
  def create
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
