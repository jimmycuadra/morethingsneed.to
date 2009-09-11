class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :entry_id, :null => false
      t.string :ip, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
