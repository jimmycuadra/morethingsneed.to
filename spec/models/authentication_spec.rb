require 'spec_helper'

describe Authentication do
  ["provider", "uid", "user"].each do |attribute|
    it "requires a #{attribute}" do
      subject.valid?
      subject.errors[attribute.to_sym].should_not be_empty
    end
  end
end
