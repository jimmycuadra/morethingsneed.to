class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :noun, :null => false
      t.string :verb, :null => false
      t.boolean :needs, :default => :false
      t.string :ip, :null => false
      t.integer :user_id

      t.timestamps
    end
    
    add_index :entries, [:noun, :verb], :unique => true
    add_index :entries, :ip
    add_index :entries, :user_id
  end
  
  def self.down
    drop_table :entries
  end
end
