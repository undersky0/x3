class AddSkillIdToSkillType < ActiveRecord::Migration
  def change
    add_column :skill_types, :skill_id, :integer
  end
end
