class FixInvites < ActiveRecord::Migration
  def up
    remove_column :invites, :sender_id
    remove_column :invites, :recepients_id
    remove_column :invites, :invitable_id
    remove_column :invites, :invitable_type
    add_column :invites, :user_id, :integer
    add_column :invites, :inviteable_id, :integer
    add_column :invites, :inviteable_type, :string
    
  end

  def down
  end
end
