class SkillLocation < ActiveRecord::Base
  attr_accessible :skill_id, :location_id
  belongs_to :skill
  belongs_to :location
end
