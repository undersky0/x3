class CreateWards < ActiveRecord::Migration
  def change
    create_table :wards do |t|
      t.string :name
      t.integer :location_id
      t.references :warded

      t.timestamps
    end
    add_index :wards, :warded_id
  end
end
