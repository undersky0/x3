class DropConversationsTable < ActiveRecord::Migration
  def up
    drop_table :conversations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
