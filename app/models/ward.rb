class Ward < ActiveRecord::Base
  belongs_to :warded, :polymorphic => true
  has_many :locations
  attr_accessible :locations, :name, :ward_attributes, :location_id, :warded_id, :warded_type, :city
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  
  after_save :createlocalfeed
  
  def createlocalfeed
    unless !Localfeed.find_by_city(self.name).nil?
    l = Localfeed.create!(:city => self.name)
  end
  end
end
