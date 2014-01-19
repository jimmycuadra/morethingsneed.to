require 'spec_helper'

describe User do
  it "is inactive by default" do
    expect(subject).not_to be_active
  end

  describe "#activate!" do
    it "activates the user" do
      subject.activate!
      expect(subject).to be_active
    end
  end
end
