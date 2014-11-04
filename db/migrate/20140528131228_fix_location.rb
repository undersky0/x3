class FixLocation < ActiveRecord::Migration
  def up
    remove_column :locations, :user_id
    remove_column :locations, :localfeed_id
    remove_column :locations, :group_id
    add_column :locations, :mappable_id, :integer
    add_column :locations, :mappable_type, :string
  end

  def down
  end
end
