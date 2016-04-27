class CreateDirectedAts < ActiveRecord::Migration
  def change
    create_table :directed_ats do |t|
      t.references :user, index: true, foreign_key: true
      t.references :toot, index: true, foreign_key: true, unique: true

      t.timestamps null: false
    end
  end
end
