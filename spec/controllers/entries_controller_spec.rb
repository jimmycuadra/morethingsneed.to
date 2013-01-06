require "spec_helper"

describe EntriesController do
  describe "#create" do
    let(:current_user) do
      current_user = double("current user")
      current_user.stub(:entries) { entries }
      current_user
    end

    let(:entries) { double("entries association") }

    let(:entry_params) do
      { "noun" => "foo", "needs" => true, "verb" => "bar" }
    end

    it "creates a new entry" do
      controller.stub(:current_user) { current_user }
      current_user.entries.should_receive(:create).with(entry_params)
      post :create, entry: entry_params
    end
  end
end