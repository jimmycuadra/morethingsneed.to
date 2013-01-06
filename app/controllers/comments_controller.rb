class CommentsController < ApplicationController
  respond_to :json

  def create
    entry = Entry.find(params[:entry_id])
    respond_with entry.comments.create(comment_params) do |comment|
      comment.user_id = current_user.id
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
