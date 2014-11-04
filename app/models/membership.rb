class Membership < ActiveRecord::Base
  attr_accessible :group_id, :role, :user_id

belongs_to :user
belongs_to :group

end
