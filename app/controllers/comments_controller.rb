class CommentsController < ApplicationController
  def create
    @entry = Entry.find(params[:entry_id])
    @comment = @entry.comments.build(comment_params)
    @comment.ip = request.remote_ip
    @comment.user_id = current_user.id if current_user
    if @comment.save
      @is_ajax = request.xhr? ? true : false
      respond_to do |format|
        format.html do
          flash[:success] = 'Your opinion has been duly noted.'
          redirect_to @entry
        end
        format.mobile do
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
        format.mobile do
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
    redirect_to root_path and return unless is_admin

    @entry = Entry.find(params[:entry_id])
    @comment = Comment.find(params[:id])

    BannedIp.toggle_ban(@comment.ip)
    flash[:success] = 'More spam flags need to be toggled.'
    redirect_to @entry
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :comment)
  end
end
