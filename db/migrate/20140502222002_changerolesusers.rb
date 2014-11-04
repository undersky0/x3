class Changerolesusers < ActiveRecord::Migration
  def Change
remove_column :roles_users, :users_id
end
end
