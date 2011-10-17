class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :noun
      t.string :verb
      t.boolean :needs
      t.integer :user_id

      t.timestamps
    end
  end
end
