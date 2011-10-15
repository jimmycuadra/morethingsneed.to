require 'spec_helper'

describe User do
  it "requires a name" do
    subject.valid?
    subject.errors[:name].should_not be_empty
  end

  it "has many authentications" do
    subject.authentications.should be
  end
end
