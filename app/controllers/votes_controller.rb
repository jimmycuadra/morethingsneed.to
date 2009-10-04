class VotesController < ApplicationController
  def create
    @entry = Entry.find(params[:entry_id])
    @v = @entry.votes.build((params[:vote] || {}).merge({ :ip => request.remote_ip }))
    if @v.save
      flash[:notice] = 'Voted and noted.'
    else
      flash[:notice] = 'You already rocked the vote.'
    end
    redirect_to @entry
  end
end