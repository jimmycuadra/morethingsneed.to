class VotesController < ApplicationController
  def create
    @entry = Entry.find(params[:entry_id])
    @v = @entry.votes.build((params[:vote] || {}).merge({ :ip => request.remote_ip }))
    if @v.save
      flash[:success] = 'Voted and noted.'
    else
      flash[:error] = 'You did not properly rock the vote.'
    end
    redirect_to @entry
  end
end