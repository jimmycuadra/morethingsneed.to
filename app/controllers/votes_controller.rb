class VotesController < ApplicationController
  def create
    @entry = Entry.find(params[:entry_id])
    @v = @entry.votes.build(vote_params || {})
    @v.ip = request.remote_ip
    if @v.save
      @entry.reload
      respond_to do |format|
        format.html do
          flash[:success] = 'Voted and noted.'
          redirect_to @entry
        end
        format.mobile do
          flash[:success] = 'Voted.'
          redirect_to @entry
        end
        format.json
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = 'You already rocked the vote.'
          redirect_to @entry
        end
        format.mobile do
          flash[:error] = 'Already voted.'
          redirect_to @entry
        end
        format.json
      end
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:up_vote)
  end
end
