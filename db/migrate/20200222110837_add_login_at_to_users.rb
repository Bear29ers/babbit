class AddLoginAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :login_at, :timestamp
  end
end
