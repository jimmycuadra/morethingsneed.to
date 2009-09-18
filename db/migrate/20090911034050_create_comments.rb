class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.text :comment, :null => false
      t.integer :entry_id, :null => false
      t.integer :user_id
      t.string :ip, :null => false

      t.timestamps
   end
   
   add_index :comments, :entry_id
   add_index :comments, :user_id
   add_index :comments, :ip
  end

  def self.down
    drop_table :comments
  end
end
