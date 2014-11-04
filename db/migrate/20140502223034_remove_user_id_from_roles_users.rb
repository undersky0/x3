class RemoveUserIdFromRolesUsers < ActiveRecord::Migration
  def up
    remove_column :roles_users, :users_id
  end

  def down
    add_column :roles_users, :user_id, :integer
  end
end
