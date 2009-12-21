class VotesController < ApplicationController
  def create
    @entry = Entry.find(params[:entry_id])
    @v = @entry.votes.build((params[:vote] || {}).merge({ :ip => request.remote_ip }))
    if @v.save
      @entry.reload
      respond_to do |format|
        format.html do
          flash[:success] = 'Voted and noted.'
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
        format.json
      end
    end
  end
end