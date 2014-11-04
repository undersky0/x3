class SkillField < ActiveRecord::Base
  belongs_to :skill_type
  attr_accessible :field_type, :name, :required
end
