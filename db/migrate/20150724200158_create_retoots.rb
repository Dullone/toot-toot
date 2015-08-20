class CreateRetoots < ActiveRecord::Migration
  def change
    create_table :retoots do |t|
      t.references :user
      t.references :toot

      t.timestamps null: false
    end
    add_index :retoots, :user
    add_index :retoots, :toot
    add_index :retoots, [:user, :toot], unique: true
  end
end

