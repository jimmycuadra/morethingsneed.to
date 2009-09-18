class CommentsController < ApplicationController    
  def new
    if request.post?
      @comment = Entry.comment.build(params[:comment])
      if @comment.save
        flash[:notice] = 'Your opinion has been duly noted.'
      else
        flash[:notice] = 'Your shit was invalid, homes.'
      end
    end
    redirect_to entry_path(params[:entry_id])
  end
end