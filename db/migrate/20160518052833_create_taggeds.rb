class CreateTaggeds < ActiveRecord::Migration
  def change
    create_table :taggeds do |t|
      t.references :tag, index: true, foreign_key: true, null: false
      t.references :toot, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
