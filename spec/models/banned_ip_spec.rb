require 'spec_helper'

describe BannedIp do
  it "rejects invalid IPs" do
    subject.ip = "not an IP"
    expect(subject).not_to be_valid
    expect(subject).to have(1).error_on(:ip)
  end

  describe ".is_banned?" do
    it "is false by default" do
      expect(described_class.is_banned?('0.0.0.0')).to be_false
    end

    it "is true when a record with the IP has been created" do
      banned_ip = FactoryGirl.create(:banned_ip)
      expect(described_class.is_banned?(banned_ip.ip)).to be_true
    end
  end

  describe ".toggle_ban" do
    let(:entry) { FactoryGirl.create(:entry) }
    let(:comment) { FactoryGirl.create(:comment, entry: entry, ip: entry.ip) }

    context "when the IP is not banned" do
      it "creates a new record" do
        expect { described_class.toggle_ban(entry.ip) }.to change { described_class.count }.by(1)
      end

      it "flags associated entries as spam" do
        expect { described_class.toggle_ban(entry.ip) }.to change {
          Entry.where(spam: true).count
        }.from(0).to(1)
      end

      it "flags associated comments as spam" do
        expect { described_class.toggle_ban(comment.ip) }.to change {
          Comment.where(spam: true).count
        }.from(0).to(1)
      end
    end

    context "when the IP is banned" do
      before do
        entry
        comment
        FactoryGirl.create(:banned_ip, ip: entry.ip)
      end

      it "destroys the existing record" do
        expect { described_class.toggle_ban(entry.ip) }.to change { described_class.count }.by(-1)
      end

      it "unflags associated entries as spam" do
        expect { described_class.toggle_ban(entry.ip) }.to change {
          Entry.where(spam: true).count
        }.from(1).to(0)
      end

      it "unflags associated comments as spam" do
        expect { described_class.toggle_ban(comment.ip) }.to change {
          Comment.where(spam: true).count
        }.from(1).to(0)
      end
    end
  end
end
