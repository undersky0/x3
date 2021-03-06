class Group::Skillimage < Asset
  has_attached_file :attachment,
  :styles => {
  :tiny => "36x36#",
  :thumb=> "60x60#",
  :feed=> "110x120#",
  :small  => "136x146#"},
  :default_url => "images/default_skill_:style.jpg",
  :processors => [:cropper]
  validates_attachment_content_type :attachment, 
  :content_type => /\Aimage\/.*\Z/
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
attr_accessible :attachment_content_type, :attachment_file_size, :attachment,
  :crop_x, :crop_y, :crop_w, :crop_h

end