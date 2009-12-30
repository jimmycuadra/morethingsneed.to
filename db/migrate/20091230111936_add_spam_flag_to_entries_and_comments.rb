class AddSpamFlagToEntriesAndComments < ActiveRecord::Migration
  def self.up
    add_column :entries, :spam, :boolean, :null => :false, :default => :false
    add_column :comments, :spam, :boolean, :null => :false, :default => :false
    
    add_index :entries, :spam
    add_index :comments, :spam
  end

  def self.down
    remove_column :entries, :spam
    remove_column :comments, :spam
  end
end
