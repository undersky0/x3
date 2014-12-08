class Ward < Location
  belongs_to :warded, :polymorphic => true
  has_many :locations
  attr_accessible :location_id, :type, :city, :political, :locality
  validates :locality, :presence => true, :uniqueness => { :case_sensitive => false }
  has_one :localfeed
  after_save :createlocalfeed
  
  def createlocalfeed
    unless !Localfeed.find_by_locality(self.locality).nil?
    l = self.create_localfeed!(:city => self.city,:locality => self.locality, :politicial => self.political, :location_id => self.location_id)
  end
  end
  
end
