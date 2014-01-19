require 'spec_helper'

describe Vote do
  it "requires an entry" do
    expect(subject).not_to be_valid
    expect(subject.errors[:entry_id]).to include(a_string_matching(/blank/))
  end

  it "requires a valid IP" do
    subject.ip = "lol"
    expect(subject).not_to be_valid
    expect(subject.errors[:ip]).to include(a_string_matching(/valid/))
  end

  it "requires an up_vote value" do
    expect(subject).not_to be_valid
    expect(subject.errors[:up_vote]).to include(a_string_matching(/not included/))
  end

  it "increases an entry's up_vote_count when upvoting" do
    entry = FactoryGirl.create(:entry)
    expect { FactoryGirl.create(:vote, entry: entry) }.to change { entry.up_vote_count }.by(1)
  end

  it "increases an entry's down_vote_count when downvoting" do
    entry = FactoryGirl.create(:entry)
    expect { FactoryGirl.create(:vote, up_vote: false, entry: entry) }.to change {
      entry.down_vote_count
    }.by(1)
  end

  it "rejects multiple votes from the same IP" do
    vote = FactoryGirl.create(:vote)
    subject = FactoryGirl.build(:vote, entry: vote.entry, ip: vote.ip)
    expect(subject).not_to be_valid
    expect(subject.errors[:ip]).to include(a_string_matching(/taken/))
  end
end
