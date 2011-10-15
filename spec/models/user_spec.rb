require 'spec_helper'

describe User do
  it "requires a name" do
    subject.valid?
    subject.errors[:name].should_not be_empty
  end
end
