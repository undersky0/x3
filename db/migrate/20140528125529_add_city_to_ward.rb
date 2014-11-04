class AddCityToWard < ActiveRecord::Migration
  def change
    add_column :wards, :city, :string
  end
end
