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
    it "finds existing users" do
      auth = Factory(:authentication)

      auth_hash = {
        "provider" => "test",
        "uid" => "1"
      }

      User.find_or_create_via_auth_hash(auth_hash).should == auth.user
    end
  end
end
