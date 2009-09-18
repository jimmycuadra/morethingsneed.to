class CommentsController < ApplicationController    
  def create
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.build(params[:comment])
    @comment.ip = request.remote_ip
    if @comment.save
      flash[:notice] = 'Your opinion has been duly noted.'
      redirect_to @entry
    else
      flash[:notice] = 'Your shit was invalid, homes.'
      return render :file => 'entries/show', :layout => 'application'
    end
  end
  
  def destroy
  end
end