require 'spec_helper'

describe API::V1::EntriesController do
  describe "#index" do
    it "responds with the most recent entries" do
      expect(Entry).to receive(:recent)
      get :index, format: :json
    end
  end
end
