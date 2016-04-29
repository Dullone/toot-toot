class CreateTootReplies < ActiveRecord::Migration
  def change
    create_table :toot_replies do |t|
      t.references :toot, index: true, foreign_key: true
      t.integer :reply_toot_id, index: true

      t.timestamps null: false
    end
  end
end
