class RemoveIndexFromVotes < ActiveRecord::Migration
  def up
    remove_index :votes, :name => "fk_one_vote_per_user_per_entity"
  end

  def down
  end
end
