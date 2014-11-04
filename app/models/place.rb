class Place < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :location
  belongs_to :locationable, :polymorphic => true
  
  
end
