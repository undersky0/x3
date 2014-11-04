class RemoveActivityDurationFromSkills < ActiveRecord::Migration
  def up
    remove_column :skills, :activity_duration
  end

  def down
    add_column :skills, :activity_duration, :string
  end
end
