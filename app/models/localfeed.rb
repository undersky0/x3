class Localfeed < ActiveRecord::Base
  attr_accessible :city, :scribble_id, :location_id, :localfeed_id, :scribble_attributes, :localfeed_attributes
  
  has_many :scribbles, :as => :scribbled
  accepts_nested_attributes_for :scribbles
  before_validation :downcase_city
  validates :city, :presence => true, :uniqueness => { :case_sensitive => false }
  has_one :location, :as => :mappable
  
  has_one :ward, :as => :warded
  
  
  private
  def downcase_city
    self.city = self.city.downcase if self.city.present?
  end
  
  def first_scribble
    self.scribbles.create(:post => "Welcome, You are the first in your location! ")
  end
  # after_validation :savefeed
#   
#   
#   
#   
  # def savefeed
    # self.save!
  # end
end
