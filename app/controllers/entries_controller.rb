class EntriesController < ApplicationController
  respond_to :json

  def index
    @entries = Entry.order("created_at ASC")

    respond_to do |format|
      format.html
      format.json { render json: @entries }
    end
  end

  def create
    respond_with Entry.create(params[:entry])
  end
end
