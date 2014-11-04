class Fixskills < ActiveRecord::Migration
  def up
		remove_column :skills, :properties
  end

  def down
  end
end
