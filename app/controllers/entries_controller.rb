class EntriesController < ApplicationController
  def index
    @entries = nil

    respond_to do |format|
      format.html
      format.json { render json: @entries }
    end
  end
end
