class Location < ActiveRecord::Base
  include ActiveModel::Validations
  validates :address, :latitude, :longitude, :postcode,:city, presence: true
  belongs_to :mappable, :polymorphic => true
  
  searchkick word_start: [:city]
  #has_one :map, :dependent => :destroy
  
  belongs_to :ward
  accepts_nested_attributes_for :ward
  has_one :localfeed
  attr_accessible :address, :latitude, :longitude, :postcode, :user_id, :actor_id, :group_id,
    :country,  
    :country_code,  
    :postal_code,  
    :city,  
    :political,  
    :locality,  
    :sublocality,  
    :street_address,
    :google_address,
    :location_attributes,
    :mappable_id,
    :mappable_type,
    :ward_id,
    :location
      
  geocoded_by :to_s
  #before_save :geolocate
  #validate :street_address, :address_validator => true
  
  after_validation :geocode
  #before_save :geolocate
  after_save :ward_exists?
  #after_save :ward_present #creates new ward and feed if not existant
  
  def address_changed?
  attrs = %w(street_address city postal_code)
  attrs.any?{|a| send "#{a}_changed?"}
  end
  
  def to_s
    "#{google_address} #{city} #{postal_code}" +" GB"
  end
  
  def gmaps4rails_address
    address
  end
  
  def ward_present
    if self.ward_id = nil?
      w = Ward.find_by_name(self.city)
      self.ward_id = w.id
    else
      self.destroy
    end
  end
  
    geocoded_by :to_s do |prof,results|
  if result = results.select{|res| res.country_code == "GB" }.first
    unless (result.latitude.nil? || result.longitude.nil?)
      prof.latitude = result.latitude
      prof.longitude = result.longitude
      prof.country = result.country
      prof.postal_code = result.postal_code
      prof.city = result.city
      #prof.political = result.political
     # prof.locality = result.locality
    #  prof.sublocality = result.sublocality
      prof.street_address = result.street_address
    end
    result.coordinates
  end
end
  
  def geolocate 
    res = GoogleGeocoder.geocode(to_s)
    
    if res.success

    self.latitude = res.latitude
    self.lonitude = res.longitude
    else
      errors[:base] << "geocoding failed, check address"
      return false
  end
  end
  
  
  def ward_exists?
    unless self.city.nil?
    w = Ward.find_by_name(self.city)
    if w.nil?
      createward
    end
    end
  end
  
  def createward
     c = self.create_ward!({:name => self.city, :city => self.city}) # should be [name => self.sublocality]
    self.ward_id = c.id
  end

  

  def self.users_city(city)
    self.where(:mappable_type => "User", :city => city).map(&:mappable_id).uniq
    #returns array  of user_ids!
  end
  
  # def search_and_fill_latlng(address=nil)
    # okresponse = false
    # geocoder = "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address="
# 
    # if address == nil
      # address = self.address
    # end
# 
    # if address != nil && address != ""
      # url = URI.escape(geocoder+address)
      # resp = RestClient.get(url)
      # result = JSON.parse(resp.body)
# 
      # if result["status"] == "OK"
        # self.latitude = result["results"][0]["geometry"]["location"]["lat"]
        # self.longitude = result["results"][0]["geometry"]["location"]["lng"]
        # okresponse = true
      # end
    # end
    # okresponse
  # end

  
end
