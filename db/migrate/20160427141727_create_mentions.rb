class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :toot, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :mentions, [:user_id, :toot_id], unique: true
  end
end
