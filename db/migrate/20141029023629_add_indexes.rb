class AddIndexes < ActiveRecord::Migration
  def change
		add_index :albums, [:albumable_id, :albumable_type]
		add_index :assets, [:assetable_id, :assetable_type]
		add_index :authentications, :uid
		add_index :authentications, :user_id
		add_index :avatars, [:avatarable_id, :avatarable_type]
		add_index :comments, :user_id
		add_index :friends, :uid
		add_index :friendships, :user_id
		add_index :friendships, :friend_id
		add_index :friendships, [:user_id, :friend_id]
		add_index :groups, :user_id
		add_index :groups, :location_id
		add_index :invites, [:inviteable_id, :inviteable_type, :status]
		add_index :localfeeds, :city
		add_index :localfeeds, :location_id
		add_index :locations, [:mappable_id, :mappable_type]
		add_index :pictures, :album_id
		add_index :profiles, :user_id
		add_index :scribbles, [:scribbled_id, :scribbled_type]
		add_index :scribbles, :user_id
    add_index :skills, :user_id
    add_index :skills, :skill_type_id
    remove_column :groups, :location_name
    remove_column :profiles, :name
  end

  def down
  end
end
