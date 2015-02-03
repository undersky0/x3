class Scribble < ActiveRecord::Base
  attr_accessible :post, :comments_attributes, :user_id, :posted_by, :localfeed_attributes
  belongs_to :user
  belongs_to :scribbled, :polymorphic => true
  has_many :comments, :as => :commentable
  accepts_nested_attributes_for :comments

  make_flaggable :promote
  acts_as_voteable
  paginates_per 12
  mount_uploader :file, FileUploader
  after_initialize :defaults
    def scribbled_type=(class_name)
     super(class_name.constantize.base_class.to_s)
  end
  
    

  def defaults
    self.promotes ||= 0
    self.demotes ||= 0
  end
end
