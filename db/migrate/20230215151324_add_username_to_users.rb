class AddUsernameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string, unique: true

    remove_index :users, :email
    add_index :users, :email
    add_index :users, :username, unique: true
  end
end
