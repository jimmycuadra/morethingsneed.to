require 'spec_helper'

describe Entry do
  describe ".recent" do
    it "returns the most recent entries in reverse chronological order" do
      e1 = FactoryGirl.create(:entry, created_at: '2014-01-03')
      e2 = FactoryGirl.create(:entry, created_at: '2014-01-01')
      e3 = FactoryGirl.create(:entry, created_at: '2014-01-02')

      expect(described_class.recent).to eq([e1, e3, e2])
    end
  end

  it "requires a noun" do
    subject.verb = "verb"
    expect(subject).not_to be_valid
    expect(subject.errors[:noun]).to include(a_string_matching(/required/))
  end

  it "requires a verb" do
    subject.noun = "noun"
    expect(subject).not_to be_valid
    expect(subject.errors[:verb]).to include(a_string_matching(/required/))
  end

  it "requires a noun and a verb" do
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/hit the button/))
  end

  it "rejects the default phrase" do
    subject.noun = "nouns"
    subject.verb = "verb"
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/hit the button/))
  end

  it "requires a valid IP" do
    subject.ip = "lol"
    expect(subject).not_to be_valid
    expect(subject.errors[:ip]).to include(a_string_matching(/valid/))
  end

  it "rejects duplicate entries" do
    entry = FactoryGirl.create(:entry, noun: "foo", verb: "bar", ip: '1.2.3.4')
    subject.noun = "FoO"
    subject.verb = "bAr"
    subject.ip = '2.3.4.5'
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/clever/))
  end

  it "rejects entries with a filled in honeypot" do
    subject.email = "foo@example.com"
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/BOTS/))
  end

  it "rejects a second entry from the same IP" do
    entry = FactoryGirl.create(:entry)
    subject = FactoryGirl.build(:entry, ip: entry.ip)
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/wait/))
  end

  it "allows second entries within a minute if the flag is set" do
    entry = FactoryGirl.create(:entry)
    subject = FactoryGirl.build(:entry, noun: "asdf", ip: entry.ip)
    subject.allow_recent_entry = true
    expect(subject).to be_valid
  end

  it "destroys dependend comments and votes" do
    entry = FactoryGirl.create(:entry)
    FactoryGirl.create(:comment, entry: entry)
    FactoryGirl.create(:vote, entry: entry)
    entry.destroy
    expect(Comment.count).to eq(0)
    expect(Vote.count).to eq(0)
  end

  it "removes trailing punctuation" do
    subject.verb = "foo!?."
    subject.valid?
    expect(subject.verb).to eq("foo")
  end

  it "removes whitespace from the noun and the verb" do
    subject.noun = "  foo   "
    subject.verb = " bar  "
    subject.valid?
    expect(subject.noun).to eq("foo")
    expect(subject.verb).to eq("bar")
  end

  it "rejects entries with URLs in the noun or verb" do
    subject.noun = subject.verb = "testing Http://www.example.com/ comments"
    expect(subject).not_to be_valid
    expect(subject.errors[:noun]).to include(a_string_matching(/URL/))
    expect(subject.errors[:verb]).to include(a_string_matching(/URL/))
  end

  it "rejects entries with the noun or verb over 255 characters" do
    subject.noun = subject.verb = "X" * 256
    expect(subject).not_to be_valid
    expect(subject.errors[:noun]).to include(a_string_matching(/wordy/))
    expect(subject.errors[:verb]).to include(a_string_matching(/wordy/))
  end

  describe "#toggle_spam" do
    it "reverses the spam flag" do
      subject = FactoryGirl.create(:entry)
      initial_spam_value = subject.spam
      subject.toggle_spam
      expect(subject.spam).not_to eq(initial_spam_value)
    end
  end

  it "rejects entries from banned IPs" do
    banned_ip = FactoryGirl.create(:banned_ip)
    subject = FactoryGirl.build(:entry, ip: banned_ip.ip)
    expect(subject).not_to be_valid
    expect(subject.errors[:base]).to include(a_string_matching(/banned/))
  end

  describe ".search" do
    it "finds entries matching the query" do
      e1 = FactoryGirl.create(:entry, noun: "pigs", verb: "snort")
      e2 = FactoryGirl.create(:entry, noun: "people", verb: "pet pigs")
      e3 = FactoryGirl.create(:entry, noun: "foo", verb: "bar")
      expect(described_class.search("pigs")).to match_array([e1, e2])
    end
  end

  describe ".by_user" do
    it "limits entries to those by a the provided user" do
      user = FactoryGirl.create(:user)
      e1 = FactoryGirl.create(:entry, user: user)
      e2 = FactoryGirl.create(:entry, user: user)
      e3 = FactoryGirl.create(:entry)
      e4 = FactoryGirl.create(:entry, user: FactoryGirl.create(:user))
      expect(described_class.by_user(e1.id)).to match_array([e1, e2])
    end
  end

  describe ".without_spam" do
    it "limits entries to those not marked as spam" do
      e1 = FactoryGirl.create(:entry, spam: false)
      e2 = FactoryGirl.create(:entry, spam: true)
      expect(described_class.without_spam).to eq([e1])
    end
  end
end
