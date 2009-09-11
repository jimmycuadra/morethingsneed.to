class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :noun, :null => false
      t.string :verb, :null => false
      t.string :ip, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
