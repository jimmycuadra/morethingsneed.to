require 'spec_helper'

describe Entry do
  ["noun", "verb", "needs", "user_id"].each do |attribute|
    it "requires attribute '#{attribute}'" do
      subject.valid?
      subject.errors[attribute.to_sym].should_not be_empty
    end
  end

  it "belongs to a user" do
    Factory(:entry).user.should be
  end

  it "must have a unique noun/verb combination" do
    Factory(:entry)
    entry = Factory.build(:entry)
    entry.valid?
    entry.errors[:base].should_not be_empty
  end
end
