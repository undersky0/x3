class FixSkills2 < ActiveRecord::Migration
  def change
    remove_column :skills, :teachers_title
    add_column :skills, :teachers_title, :string
  end
end
