class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :entry_id, :null => false
      t.string :ip, :null => false
      t.string :name
      t.text :comment, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
