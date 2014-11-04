class SkillType < ActiveRecord::Base
  attr_accessible :name, :fields_attributes, :description, :skill_id
  has_many :fields, class_name: "SkillField"
  accepts_nested_attributes_for :fields, allow_destroy: true
end
