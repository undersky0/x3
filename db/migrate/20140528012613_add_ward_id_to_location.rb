class AddWardIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :ward_id, :integer
  end
end
