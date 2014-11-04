class Event < ActiveRecord::Base
  attr_accessible :name, :location_id, :location_name, :event_type, :privacy, :about, :headline
  belongs_to :eventable, :polymorphic => true
end
