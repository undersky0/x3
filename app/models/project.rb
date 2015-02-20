class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  has_one :projectimage, :as => :assetable, :class_name => "Group::Projectimage", :dependent => :destroy
  accepts_nested_attributes_for :projectimage, reject_if: :all_blank
end
