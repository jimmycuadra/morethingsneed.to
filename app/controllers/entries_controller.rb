class EntriesController < ApplicationController
  respond_to :json

  def index
    @entries = Entry.recent(params[:page])
    js_data[:entries] = @entries
  end

  def show
    @entry = Entry.find(params[:id])
    @comment = @entry.comments.build
    js_data[:entries] = [@entry]
  end

  def create
    respond_with current_user.entries.create(entry_params)
  end

  private

  def entry_params
    params.require(:entry).permit(:noun, :needs, :verb)
  end
end
