class AddWardedTypeToWard < ActiveRecord::Migration
  def change
    add_column :wards, :warded_type, :string
  end
end
