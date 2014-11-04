class AddLocationIdToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :location_id, :integer
  end
end
