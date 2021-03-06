class Group::Useravatar < Asset
  has_attached_file :attachment,
  :styles => {
  :tiny => "36x36#",
  :thumb=> "60x60#",
  :feed=> "110x120#",
  :small  => "136x136#",
  :medium => "243x143>",
  :large => "786x500"},
  :default_url => "images/default_avatar_:style.jpg",
  :processors => [:cropper]
  validates_attachment_content_type :attachment, 
  :content_type => ['image/jpeg', 'image/png']
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
attr_accessible :attachment_content_type, :attachment_file_name, :attachment_file_size, :attachment,
  :crop_x, :crop_y, :crop_w, :crop_h
  
end