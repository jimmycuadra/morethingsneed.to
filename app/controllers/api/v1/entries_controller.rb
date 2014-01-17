class API::V1::EntriesController < API::V1::APIController
  respond_to :json

  def index
    respond_with Entry.recent
  end
end
