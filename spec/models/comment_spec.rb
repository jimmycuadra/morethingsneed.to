require 'spec_helper'

describe Comment do
  %i{comment entry_id ip}.each do |attribute|
    it "requires the #{attribute} attribute" do
      expect(subject).not_to be_valid
      expect(subject.errors[attribute]).to include(a_string_matching(/blank/))
    end
  end

  it "rejects invalid IPs" do
    expect(subject).not_to be_valid
    expect(subject.errors[:ip]).to include(a_string_matching(/valid IP/))
  end

  it "rejects names longer than 30 characters" do
    subject.name = 'x' * 31
    expect(subject).not_to be_valid
    expect(subject.errors[:name]).to include(a_string_matching(/longer than 30/))
  end

  it "rejects comments containing URLs in the name or body" do
    subject.name = subject.comment = "http://spam.com"
    expect(subject).not_to be_valid
    expect(subject.errors[:name]).to include(a_string_matching(/URL/))
    expect(subject.errors[:comment]).to include(a_string_matching(/URL/))
  end

  it "rejects comments with the honeypot filled in" do
    subject.email = "honey is tasty"
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/BOTS/))
  end

  it "rejects the 2nd comment from the same IP within 1 minute" do
    existing_comment = FactoryGirl.create(:comment)
    subject.ip = existing_comment.ip
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/eager/))
  end

  it "rejects comments from banned IPs" do
    banned_ip = FactoryGirl.create(:banned_ip)
    subject.ip = banned_ip.ip
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/banned/))
  end

  it "affects Entry's counter cache" do
    entry = FactoryGirl.create(:entry)
    expect { FactoryGirl.create(:comment, entry: entry) }.to change { entry.comment_count }.by(1)
  end

  describe "#without_spam" do
    it "returns only comments not marked as spam" do
      c1 = FactoryGirl.create(:comment, spam: true)
      c2 = FactoryGirl.create(:comment, spam: false, entry_id: c1.entry_id)
      c3 = FactoryGirl.create(:comment, spam: true, entry_id: c1.entry_id)

      expect(described_class.without_spam).to eq([c2])
    end
  end

  describe "#toggle_spam" do
    it "reverses the boolean value of the spam flag" do
      subject = FactoryGirl.create(:comment)
      initial_spam_value = subject.spam
      subject.toggle_spam
      expect(subject.spam).not_to eq(initial_spam_value)
    end
  end
end
