class AddAtUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :at_username, :string
  end
end
