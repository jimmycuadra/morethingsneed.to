class AddUpVoteToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :up_vote, :boolean
    
    add_index :votes, :up_vote
  end

  def self.down
    remove_column :votes, :up_vote
  end
end
