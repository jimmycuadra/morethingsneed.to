class AddCommentCountToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :comment_count, :integer, :null => false, :default => 0
    
    Entry.all.each do |e|
      e.update_attribute(:comment_count, e.comments.count)
    end
    
    add_index :entries, :comment_count
  end

  def self.down
    drop_column :entries, :comment_count
  end
end
