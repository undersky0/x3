class Picture < ActiveRecord::Base
  attr_accessible :description, :album_id, :file, :crop_x, :crop_y, :crop_w, :crop_h, :album_token
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  belongs_to :album
  mount_uploader :file, FileUploader
  before_create :default_name
  
  after_update :crop_image
  
  
    def default_name
    self.name ||= File.basename(image.filename, '.*').titleize if image
  end
  
  def to_jq_upload
    {
      "name" => read_attribute(:file),
      "size" => file.size,
      "url" => file.url,
      "thumbnail_url" => file.thumb.url,
      "delete_url" => id,
      "picture_id" => id,
      "delete_type" => "DELETE"
    }
  end
  
  def crop_image
    file.recreate_versions! if crop_x.present?
    current_version = self.file.current_path
    large_version = "#{Rails.root}/public" + self.file.versions[:large].to_s

    FileUtils.rm(current_version)
    FileUtils.cp(large_version, current_version)
  end
  
end
