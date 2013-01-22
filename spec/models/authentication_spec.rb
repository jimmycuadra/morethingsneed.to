require "spec_helper"

describe Authentication do
  describe ".from_omniauth" do
    let(:authentication) do
      described_class.new(provider: "facebook", uid: "1")
    end

    let(:auth_hash) do
      {
        "provider" => "facebook",
        "uid" => "1",
        "info" => {
          "name" => "Bongo"
        }
      }
    end

    before do
      described_class.stub(:where) { relation }
    end

    context "with a returning user" do
      let(:relation) do
        relation = double("relation")
        relation.stub(:first) { authentication }
        relation
      end

      it "finds the matching authentications" do
        expect(described_class.from_omniauth(auth_hash)).to eql(authentication)
      end
    end

    context "with a new user" do
      let(:relation) do
        relation = double("relation")
        relation.stub(:first) { nil }
        relation
      end

      it "creates a new user" do
        expect {
          described_class.from_omniauth(auth_hash)
        }.to change {
          User.count
        }.by(1)
      end

      it "returns the new authentication" do
        authentication = described_class.from_omniauth(auth_hash)
        expect(authentication).to be_persisted
      end
    end
  end

  describe ".from_persona" do
    let(:authentication) do
      described_class.new(provider: "persona", uid: "bongo@example.com")
    end

    let(:json) do
      MultiJson.dump(status: "okay", email: "bongo@example.com")
    end

    let(:response) do
      response = double("response")
      response.stub(:body) { json }
      response
    end

    before do
      Faraday.stub(:post) { response }
    end

    context "with a returning user" do
      let(:relation) do
        relation = double("relation")
        relation.stub(:first) { authentication }
        relation
      end

      before do
        described_class.stub(:where) { relation }
      end

      it "finds the matching authentication" do
        expect(described_class.from_persona("assertion")).to eql(authentication)
      end
    end

    context "with a new user" do
      let(:relation) do
        relation = double("relation")
        relation.stub(:first) { nil }
        relation
      end

      before do
        described_class.stub(:where) { relation }
      end

      it "creates a new user" do
        expect {
          described_class.from_persona("assertion")
        }.to change {
          User.count
        }.by(1)
      end

      it "returns the new authentication" do
        authentication = described_class.from_persona("assertion")
        expect(authentication).to be_persisted
      end
    end

    context "when the assertion verification fails" do
      let(:json) do
        MultiJson.dump(status: "failure")
      end

      it "raises an error" do
        expect {
          described_class.from_persona("assertion")
        }.to raise_error(Authentication::PersonaAssertionError)
      end
    end
  end
end
