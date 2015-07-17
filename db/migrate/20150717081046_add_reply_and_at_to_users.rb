class AddReplyAndAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reply, :integer, index:true
    add_column :users, :at, :integer, index: true
  end
end
