class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :about
      t.integer :user_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
