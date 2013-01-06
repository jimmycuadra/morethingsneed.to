class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.integer :user_id, null: false
      t.integer :entry_id, null: false

      t.timestamps
    end

    add_index :comments, :user_id
  end
end
