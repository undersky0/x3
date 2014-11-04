class Gallery < ActiveRecord::Base
  has_many :attachables
  belongs_to :gallerable, :polymorphic => true
  accepts_nested_attributes_for :attachables
end
