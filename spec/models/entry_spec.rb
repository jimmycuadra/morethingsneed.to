require 'spec_helper'

describe Entry do
  ["noun", "verb", "needs", "user_id"].each do |attribute|
    it "requires attribute '#{attribute}'" do
      subject.valid?
      subject.errors[attribute.to_sym].should_not be_empty
    end
  end
end
