class EntriesController < ApplicationController
  respond_to :json

  def index
  end

  def create
    respond_with current_user.entries.create(params)
  end
end
