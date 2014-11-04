class AddTypeToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :skill_type_id, :integer
    add_column :skills, :properties, :text
  end
end
