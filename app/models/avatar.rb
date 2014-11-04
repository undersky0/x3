class Avatar < ActiveRecord::Base
  
  belongs_to :avatarable, :polymorphic => true
  attr_accessible :photo_content_type, :photo_file_name, :photo_file_size, :photo
  delegate :url, :to => :photo
  has_attached_file :photo,
  :styles => {
  :tiny => "36x36#",
  :thumb=> "60x60#",
  :feed=> "110x120#",
  :small  => "136x136#",
  :medium => "243x143>",
  :large =>   "400x400>" ,
  :gcover => "1078x286"},
  :default_url => "./images/default_avatar_:style.jpg"
  validates_attachment_content_type :photo, :content_type => /^image\/(png|gif|jpeg)/
end
