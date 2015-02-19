class Skillpictures < ActiveRecord::Base
  has_attached_file :file
  validates_attachment_content_type :file, :content_type => /^image\/(png|gif|jpeg)/
  validates_attachment_size :file, :in => 0..1.megabytes
  validates_attachment :file, presence: true
end
