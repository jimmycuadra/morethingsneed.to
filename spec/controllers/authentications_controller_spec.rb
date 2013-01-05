require "spec_helper"

describe AuthenticationsController do
  describe "#create" do
    let(:omniauth_hash) { double("omniauth hash") }
    let(:authentication) { Authentication.new }

    before do
      controller.env["omniauth.auth"] = omniauth_hash
      Authentication.stub(:find_or_create_via_omniauth) { authentication }
      controller.stub(:login)
    end

    it "gets an Authentication via the OmniAuth hash" do
      Authentication.should_receive(:find_or_create_via_omniauth).with(omniauth_hash)
      get :create, provider: "facebook"
    end

    it "logs the user in" do
      controller.should_receive(:login).with(authentication.user)
      get :create, provider: "facebook"
    end

    it "redirects to the home page" do
      get :create, provider: "facebook"
      expect(response).to redirect_to(root_path)
    end
  end
end
