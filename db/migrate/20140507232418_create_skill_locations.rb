class CreateSkillLocations < ActiveRecord::Migration
  def change
    create_table :skill_locations do |t|
        t.belongs_to :skill
        t.belongs_to :location
      t.timestamps
    end
  end
end
