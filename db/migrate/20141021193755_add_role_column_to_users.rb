class AddRoleColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :stringp
  end
end
