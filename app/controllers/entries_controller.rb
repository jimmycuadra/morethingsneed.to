class EntriesController < ApplicationController
  respond_to :json

  def index
    respond_with Entry.order("created_at ASC")
  end

  def create
    respond_with Entry.create(params[:entry])
  end
end
