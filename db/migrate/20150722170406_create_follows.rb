class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :followed_id
      t.integer :follower_id

      t.timestamps null: false
    end
    add_index :follows, :follower_id
    add_index :follows, :followed_id
    add_index :follows, [:followed_id, :follower_id], unique: true
  end
end
