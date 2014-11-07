class FixLocalfeed < ActiveRecord::Migration
  def change
    remove_column :localfeeds, :scribble_id
    add_column :localfeeds, :ward_id, :integer
  end
end
