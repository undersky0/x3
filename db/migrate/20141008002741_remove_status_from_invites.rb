class RemoveStatusFromInvites < ActiveRecord::Migration
  def up
    remove_column :invites, :status
    add_column :invites, :status, :string
  end

  def down
  end
end
