class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :noun, :null => false
      t.string :verb, :null => false
      t.boolean :needs, :default => 0
      t.string :ip, :null => false
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
