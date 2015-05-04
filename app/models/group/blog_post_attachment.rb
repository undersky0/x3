class Group::BlogPostAttachment < Asset
  has_attached_file :attachment,
                    :styles => {:small  => "136x146#"},
                    :default_url => "images/default_skill_:style.jpg",
                    :processors => [:cropper]
  validates_attachment_content_type :attachment,
                                    :content_type => /\Aimage\/.*\Z/
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :attachment_content_type, :attachment_file_size, :attachment,
                  :crop_x, :crop_y, :crop_w, :crop_h

end