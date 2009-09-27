class CommentsController < ApplicationController    
  def create
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.build(params[:comment])
    @comment.ip = request.remote_ip
    @comment.user_id = current_user.id if current_user
    if @comment.save
      flash[:notice] = 'Your opinion has been duly noted.'
      redirect_to @entry
    else
      flash.now[:notice] = 'Your shit was invalid, homes.'
      @new_entry = Entry.new
      return render :file => 'entries/show', :layout => 'application'
    end
  end
  
  def destroy
  end
end