class Localfeed < Location
  attr_accessible :city, :locality, :political, :location_id, :location_attributes, :localfeed_attributes
  
  has_many :scribbles, :as => :scribbled
  accepts_nested_attributes_for :scribbles 
  
  before_save {|localfeed| 
    localfeed.locality = localfeed.locality.downcase
    localfeed.city = localfeed.locality.downcase
    }
  private

  
  def first_scribble
    self.scribbles.create!(:user_id => User.first.id, :post => "Welcome, You are the first in #{self.city} to join our network! ")
  end
  
  def city_areas(city)
    Localfeed.where(city: city).map(&:locality).uniq
  end
  
  def cities
    Localfeed.all.map(&:city).uniq
  end

  def locality_name
    locality ? locality.capitalize : nil
  end
end
