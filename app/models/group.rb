class Group < ActiveRecord::Base
  include ActiveModel::Validations
  # validates_length_of :name, :within => 3..20, :wrong_lenght => "Try a name between 5 and 20 characters. {{count}}"
  # validates_lenght_of :about, :within => 1..2000, :wrong_lenght => "A little too long ?. {{count}}"
  validates_presence_of :name, :group_type
  has_one :igroupcover, :as => :assetable, :class_name => "Group::Igroupcover", :dependent => :destroy
  accepts_nested_attributes_for :igroupcover, reject_if: :all_blank
  # acts_as_authorization_object
  searchkick autocomplete: ['name']
  attr_accessible :location_attributes, :image_attributes, :name,
                   :location_id, :location_name, :scribble_attributes, 
                   :group_type, :privacy, :about, :membership_id, :event_id, :headline, :avatar_attributes, :user_id, :igroupcover_attributes 
                   
  
  
  has_many :users, :through => :memberships
  has_many :memberships
  
  has_one :location, :as => :mappable,
  dependent: :destroy
  accepts_nested_attributes_for :location
  
  has_many :events, :as => :eventable, :dependent => :destroy
  accepts_nested_attributes_for :events
  
  has_many :scribbles, :as => :scribbled, :dependent => :destroy
  accepts_nested_attributes_for :scribbles
  
  has_many :galleries, :as => :gallerable, :dependent => :destroy
  accepts_nested_attributes_for :galleries

  has_many :albums, :as => :albumable, :dependent => :destroy
  accepts_nested_attributes_for :albums
  
  belongs_to :user
  
  
  
  def build_avatar
     if self.igroupcover.nil?
       self.build_igroupcover()
     end
  end
  after_create :build_avatar


end
