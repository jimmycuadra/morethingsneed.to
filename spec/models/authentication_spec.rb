require 'spec_helper'

describe Authentication do
  ["provider", "uid", "user_id"].each do |attribute|
    it "requires #{attribute} attribute" do
      subject.valid?
      subject.errors[attribute.to_sym].should_not be_empty
    end
  end

  it "belongs to a user" do
    authentication = Factory(:authentication)
    authentication.user.should be
  end
end
