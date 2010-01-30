class CreateBannedIps < ActiveRecord::Migration
  def self.up
    create_table :banned_ips do |t|
      t.string :ip, :null => false

      t.timestamps
    end
    
    add_index :banned_ips, :ip
  end

  def self.down
    drop_table :banned_ips
  end
end
