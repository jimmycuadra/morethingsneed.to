class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :noun, null: false
      t.string :verb, null: false
      t.boolean :needs, null: false
      t.integer :user_id

      t.timestamps
    end

    add_index :entries, [:noun, :verb]
  end
end
