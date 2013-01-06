class EntriesController < ApplicationController
  respond_to :json

  def index
  end

  def create
    respond_with current_user.entries.create(entry_params)
  end

  private

  def entry_params
    params.require(:entry).permit(:noun, :needs, :verb)
  end
end
