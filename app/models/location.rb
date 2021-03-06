class Location < ActiveRecord::Base
  include ActiveModel::Validations
  validates_presence_of :address, message: "Address can't be blank"
  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :city, message: "can't be blank"
  validates_presence_of :postcode, message: "Invalid postcode"
  validates_format_of :postcode, :multiline => true, :with =>  /^([A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\s?[0-9][ABD-HJLNP-UW-Z]{2}|(GIR\ 0AA)|(SAN\ TA1)|(BFPO\ (C\/O\ )?[0-9]{1,4})|((ASCN|BBND|[BFS]IQQ|PCRN|STHL|TDCU|TKCA)\ 1ZZ))$$/i, :message => "invalid postcode", :on => :create
  belongs_to :mappable, :polymorphic => true
  include HTTParty
  searchkick word_start: [:city]

  has_many :scribbles, :as => :scribbled
  accepts_nested_attributes_for :scribbles 
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
    :location,
    :type
  
  after_validation :geocode
  before_validation :downcase
  before_save :get_ward, if: :postcode? 
  
   before_save { |location|
     location.city = location.city.downcase
     location.try(:locality).try(downcase)
     location.political = location.political.downcase}
   after_save :first_scribble, if: :postcode? 
  
  def get_ward
    postcode = self.postcode.delete(' ')
    response = HTTParty.get("http://api.postcodes.io/postcodes/#{postcode}").parsed_response
    if response["status"] == 200
    self.locality = response["result"]["admin_ward"]
    self.political = response["result"]["parliamentary_constituency"]
    self.city = response["result"]["admin_district"]
    self.longitude = response["result"]["longitude"]
    self.latitude = response["result"]["latitude"]
    createlocalfeed unless self.locality.nil?
    else
      errors[:base] << "Invalid address"
    end
  end
  
  def address_changed?
  attrs = %w(street_address city postal_code locality)
  attrs.any?{|a| send "#{a}_changed?"}
  end
  
  def address_string
    "#{google_address} #{city} #{postcode}" +" GB"
  end
  
  def ward_present
    if self.ward_id = nil?
      w = Ward.find_by_name(self.city)
      self.ward_id = w.id
    else
      self.destroy
    end
  end
  
    geocoded_by :address_string do |prof,results|
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
    res = GoogleGeocoder.geocode(address_string)
    if res.success
    self.latitude = res.latitude
    self.lonitude = res.longitude
    else
      errors[:base] << "geocoding failed, check address"
      return false
  end
  end
  
  
  def ward_exists?
    w = nil
    w = Ward.find_by_name(self.city) unless self.city.nil?
    createward if w.nil?
  end
  
  def locality=(val)
    self[:locality] = val
  end
  
  def political=(val)
    self[:political] = val
  end
  
  def createlocalfeed
   l = Location.where(locality: self.locality.downcase).count
    if l == 0
      self.type = "Localfeed"
    else
      return l 
    end
  end
  
  def createward
    tries ||= 2
    begin
    @c = Ward.where(
     locality: self.locality,
     political: self.political,
     city: self.city).first_or_initialize
    @c.save(validate:false) unless @c.id
    rescue ActiveRecord::RecordNotUnique
        retry unless (tries -= 1).zero?
    end
     self.ward_id = @c.id if self.ward_id.nil?
  end

  def self.users_city(city)
    self.where(:mappable_type => "User", :city => city).map(&:mappable_id).uniq
  end
  
  def downcase
    self.city = self.city.downcase if self.city.present?
    self.political = self.political.downcase if self.political.present?
    self.locality = self.locality.downcase if self.locality.present?
  end

  def first_scribble
    self.scribbles.create!(:user_id => User.first.id, :post => "Welcome, You are the first in #{self.locality} to join our network! ") if self.type.present?
  end
  
  def city_localities(city)
      Location.where(city: city).map
  end
end
