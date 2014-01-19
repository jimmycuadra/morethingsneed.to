require 'spec_helper'

describe Contact do
  %i{name real_email message}.each do |attribute|
    it "requires the #{attribute} attribute" do
      expect(subject).not_to be_valid
      expect(subject.errors[attribute]).to include("can't be blank")
    end
  end

  it "requires a valid email" do
    subject.real_email = "lol"
    expect(subject).not_to be_valid
    expect(subject.errors[:real_email]).to include(a_string_matching(/invalid/))
  end

  it "rejects contacts with the honeypot filled in" do
    subject.email = "foo@example.com"
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/BOTS/))
  end
end
