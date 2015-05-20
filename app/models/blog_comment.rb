class BlogComment < ActiveRecord::Base
  belongs_to :blogPost, :dependent => :destroy, foreign_key: "blog_post_id"
  validates :comment, :name, presence: true
end
