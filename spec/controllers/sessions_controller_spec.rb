require "spec_helper"

describe SessionsController do
  describe "#create" do
    let(:authentication) { Authentication.new }

    describe "using OmniAuth" do
      let(:omniauth_hash) { double("omniauth hash") }

      before do
        controller.env["omniauth.auth"] = omniauth_hash
        Authentication.stub(:from_omniauth) { authentication }
      end

      it "gets an Authentication via the OmniAuth hash" do
        Authentication.should_receive(:from_omniauth).with(omniauth_hash)
        get :create, provider: "facebook"
      end

      it "redirects to the home page" do
        get :create, provider: "facebook"
        expect(response).to redirect_to(root_path)
      end
    end

    describe "using Persona" do
      let(:assertion) { double("Persona assertion") }

      before do
        Authentication.stub(:from_persona) { authentication }
      end

      it "gets an Authentication via Persona assertion" do
        Authentication.should_receive(:from_persona).with(assertion)
        post :create, assertion: assertion, format: "js"
      end

      it "returns a 201 Created status" do
        post :create, assertion: assertion, format: "js"
        expect(response.status).to eql(201)
      end

      it "returns a 401 Unauthorized status if the assertion verification fails" do
        Authentication.stub(:from_persona).and_raise(
          Authentication::PersonaAssertionError.new("Assertion verification failed.")
        )
        post :create, assertion: assertion, format: "js"
        expect(response.status).to eql(401)
        expect(response.body).to eql("Assertion verification failed.")
      end
    end
  end

  describe "#destory" do
    it "removes user_id from the session" do
      session[:user_id] = 1
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects back to the home page" do
      get :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
