class ChangeWard < ActiveRecord::Migration
  def change
  add_column :wards, :locality, :string
  add_column :wards, :political, :string
  remove_column :wards, :name
  remove_column :wards, :warded_type   
  end
end
