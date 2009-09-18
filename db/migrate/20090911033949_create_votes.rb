class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :entry_id, :null => false
      t.integer :user_id
      t.string :ip, :null => false

      t.timestamps
    end
    
    add_index :votes, :entry_id
    add_index :votes, [:entry_id, :user_id], :unique => true
    add_index :votes, :ip
  end

  def self.down
    drop_table :votes
  end
end
