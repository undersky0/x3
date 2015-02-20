class FixProfile < ActiveRecord::Migration
  def change
		add_column :profiles, :about, :text
		add_column :profiles, :skills, :string
		add_column :profiles, :interests, :string
		add_column :profiles, :university, :string
		add_column :profiles, :college, :string
		add_column :profiles, :school, :string
  end
end
