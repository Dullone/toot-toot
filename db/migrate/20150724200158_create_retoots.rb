class CreateRetoots < ActiveRecord::Migration
  def change
    create_table :retoots do |t|
      t.references :user
      t.references :toot

      t.timestamps null: false
    end
  end
end
