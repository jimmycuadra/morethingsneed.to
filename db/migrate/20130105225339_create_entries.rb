class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :noun, null: false
      t.string :verb, null: false
      t.boolean :needs, default: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :entries, :user_id
  end
end
