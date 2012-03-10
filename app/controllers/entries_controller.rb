class EntriesController < ApplicationController
  def index
    @entries = Entry.order("created_at DESC")

    respond_to do |format|
      format.html
      format.json { render json: @entries }
    end
  end
end
