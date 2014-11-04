class CreateSkillFields < ActiveRecord::Migration
  def change
    create_table :skill_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :skill_type

      t.timestamps
    end
    add_index :skill_fields, :skill_type_id
  end
end
