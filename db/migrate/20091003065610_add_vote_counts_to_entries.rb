class AddVoteCountsToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :up_vote_count, :integer, :default => 0
    add_column :entries, :down_vote_count, :integer, :default => 0
    
    Entry.all.each do |e|
      e.update_attributes(:up_vote_count => e.votes.find_all_by_up_vote(true).count, :down_vote_count => e.votes.find_all_by_up_vote(false).count)
    end
  end

  def self.down
    remove_column :entries, :up_vote_count
    remove_column :entries, :down_vote_count
  end
end
