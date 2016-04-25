class CreateRetoots < ActiveRecord::Migration
  def change
    create_table :retoots do |t|
      t.references :user
      t.references :toot

      t.timestamps null: false
    end
    add_index :retoots, :user_id
    add_index :retoots, :toot_id
    add_index :retoots, [:user_id, :toot_id], unique: true
  end
end

