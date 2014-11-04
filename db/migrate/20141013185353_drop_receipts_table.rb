class DropReceiptsTable < ActiveRecord::Migration
  def up
    drop_table :receipts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
