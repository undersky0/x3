class Attachable < ActiveRecord::Base
  belongs_to :gallery
  attr_accessible :image_content_type, :image_file_name, :image_file_size, :image
  
  has_attached_file :image,
  :styles => {
  :thumb=> "100x100#",
  :small  => "150x150>",
  :medium => "300x300>",
  :large =>   "400x400>" },
  :default_url => "/images/:style/default_avatar.png"
  validates_attachment_content_type :image, :content_type => 'image/jpeg'
end
