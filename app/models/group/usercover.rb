class Group::Usercover < Asset
  has_attached_file :attachment,
  :styles => {
  :small  => "136x136#",
  :large => "1044x286"},
  :default_url => "./images/default_usercover_:style.jpg",
  :processors => [:cropper]
  validates_attachment_content_type :attachment, 
  :content_type => ['image/jpeg', 'image/png']
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
attr_accessible :attachment_content_type, :attachment_file_name, :attachment_file_size, :attachment,
  :crop_x, :crop_y, :crop_w, :crop_h
  
end