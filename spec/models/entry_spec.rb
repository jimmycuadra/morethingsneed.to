require "spec_helper"

describe Entry do
  describe ".recent" do
    let(:ordered_relation) { double("ordered relation") }

    let(:paginated_relation) do
      relation = double("paginated relation")
      relation.stub(:order) { ordered_relation }
      relation
    end

    before do
      Entry.stub(:page) { paginated_relation }
    end

    it "paginates the most recent entries" do
      expect(Entry.recent).to eql(ordered_relation)
    end
  end
end
