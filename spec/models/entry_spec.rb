require 'spec_helper'

describe Entry do
  describe ".recent" do
    it "returns the most recent entries" do
      entries = [
        FactoryGirl.create(:entry, created_at: '2014-01-03'),
        FactoryGirl.create(:entry, created_at: '2014-01-02'),
        FactoryGirl.create(:entry, created_at: '2014-01-01')
      ]

      expect(described_class.recent).to eq(entries)
    end
  end
end
