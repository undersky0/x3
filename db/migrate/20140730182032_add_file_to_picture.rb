class AddFileToPicture < ActiveRecord::Migration
  def change
    add_column :scribbles, :file, :string
  end
end
