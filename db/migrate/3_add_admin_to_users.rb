class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :superior, :boolean, default: false
  end
end
