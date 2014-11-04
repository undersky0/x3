class AddDescriptionToSkillTypes < ActiveRecord::Migration
  def change
    add_column :skill_types, :description, :string
  end
end
