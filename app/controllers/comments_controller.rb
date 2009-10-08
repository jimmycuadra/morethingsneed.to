class CommentsController < ApplicationController    
  def create
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.build(params[:comment])
    @comment.ip = request.remote_ip
    @comment.user_id = current_user.id if current_user
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:notice] = 'Your opinion has been duly noted.'
          redirect_to @entry
        end
        format.json
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:notice] = 'Your shit was invalid, homes.'
          @new_entry = Entry.new
          return render :file => 'entries/show', :layout => 'application'
        end
        format.json
      end
    end
  end
  
  def destroy
  end
end