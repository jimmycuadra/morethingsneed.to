require 'spec_helper'

describe User do
  it "requires a name" do
    subject.valid?
    subject.errors[:name].should_not be_empty
  end

  it "has many authentications" do
    subject.authentications.should be
  end

  describe ".find_or_create_via_auth_hash" do
    let(:auth_hash) do
      {
        "provider" => "test",
        "uid" => "1",
        "info" => {
          "name" => "Bongo",
          "email" => "bongo@example.com"
        },
        "credentials" => {
          "token" => SecureRandom.hex(8),
          "secret" => SecureRandom.hex(8)
        }
      }
    end

    it "finds existing users" do
      auth = Factory(:authentication)
      User.find_or_create_via_auth_hash(auth_hash).should == auth.user
    end

    it "creates a new user when no user is found" do
      expect {
        User.find_or_create_via_auth_hash(auth_hash)
      }.to change { User.count }.from(0).to(1)
    end
  end
end
