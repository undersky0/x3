class Group::Projectimage < Asset
  has_attached_file :attachment,
  :styles => {
  :small  => "136x146#"},
  :default_url => "images/default_skill_:style",
  :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :attachment_content_type, :attachment_file_size, :attachment,
  :crop_x, :crop_y, :crop_w, :crop_h
  validates_attachment_content_type :attachment, :content_type => /^image\/(png|gif|jpeg)/
  validates_attachment_size :attachment, :in => 0..1.megabytes
  validates_attachment :attachment, presence: true
end