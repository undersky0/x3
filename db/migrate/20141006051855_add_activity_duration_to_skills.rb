class AddActivityDurationToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :activity_duration, :time
  end
end
