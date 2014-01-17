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
end
