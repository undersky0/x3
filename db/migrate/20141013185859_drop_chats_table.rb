class DropChatsTable < ActiveRecord::Migration
  def up
    drop_table :chats
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
