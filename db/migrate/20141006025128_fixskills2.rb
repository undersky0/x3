class Fixskills2 < ActiveRecord::Migration
  def up
    remove_column :skills, :activity_duration
  end

  def down
  end
end
