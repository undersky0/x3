class AddLocalityAndPoliticalToLocalfeeds < ActiveRecord::Migration
  def change
    add_column :localfeeds, :locality, :string
    add_column :localfeeds, :political, :string
  end
end
