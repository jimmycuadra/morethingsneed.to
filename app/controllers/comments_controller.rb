class CommentsController < ApplicationController    
  def create
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.build(params[:comment])
    @comment.ip = request.remote_ip
    @comment.user_id = current_user.id if current_user
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = 'Your opinion has been duly noted.'
          redirect_to @entry
        end
        format.json
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Your shit was invalid, homes.'
          @new_entry = Entry.new
          return render :file => 'entries/show', :layout => 'application'
        end
        format.json
      end
    end
  end
  
  def destroy
  end
  
  def toggle_spam
    @entry = Entry.find(params[:entry_id])
    redirect_to @entry and return unless is_admin
    
    @comment = Comment.find(params[:id])
    
    new_spam_value = @comment.spam ? false : true
    @comment.update_attribute :spam, new_spam_value
    flash[:success] = 'More spam flags need to be toggled.'
    redirect_to @entry
  end
end