class BlogComment < ActiveRecord::Base
  belongs_to :blogPost, :dependent => :destroy
  validates :comment, :name, :presence => :true
end
