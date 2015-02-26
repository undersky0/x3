class Endorsement < ActiveRecord::Base
  belongs_to :user
  belongs_to :endorser, :class_name => "User"
end
