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
    context "when the IP is not banned" do
      it "creates a new record" do
        expect { described_class.toggle_ban('1.2.3.4') }.to change { described_class.count }.by(1)
      end

      it "flags associated entries as spam"
      it "flags associated comments as spam"
    end

    context "when the IP is banned" do
      before { FactoryGirl.create(:banned_ip, ip: '1.2.3.4') }

      it "destroys the existing record" do
        expect { described_class.toggle_ban('1.2.3.4') }.to change { described_class.count }.by(-1)
      end

      it "unflags associated entries as spam"
      it "unflags associated comments as spam"
    end
  end
end
