class AddActivityDurationFromSkills < ActiveRecord::Migration
  def change
    add_column :skills, :activity_duration, :string
  end
end
