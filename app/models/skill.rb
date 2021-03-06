class Skill < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :user
  searchkick word_start: [:name]
  #after_save :reindex
  before_save :build_image
  attr_accessible :photo_attributes, :name, :description,
  :skill_type_id, :properties, :teachers_title, :necessary_resources, :level, 
  :required_experience,:price, :start_date, :min_students, :max_students, :activity_duration,
  :location_id, :user_id, :location_attributes, :skill_type_attributes, :skillimage_attributes
  
  has_many :invites, :as => :inviteable
  accepts_nested_attributes_for :invites
  # has_one :ward, :as => :warded

  has_one :location, :as => :mappable, :dependent => :destroy
  accepts_nested_attributes_for :location

  has_one :skillimage, :as => :assetable, :class_name => "Group::Skillimage", :dependent => :destroy
  accepts_nested_attributes_for :skillimage, reject_if: :all_blank
  
  
  validates :name, length: {minimum: 2, maximum: 60}
  validates :teachers_title, length: {minimum: 2, maximum: 70}
  validates :description, length:{in: 1..2500}
  validates :teachers_title, :price, :start_date, :activity_duration, 
                      :level, :min_students, :max_students, presence: true

  has_many :users_joined, -> { where(status: 'Joined')}, :class_name => 'Invite', foreign_key: :inviteable_id
  has_many :watchers, -> { where(status: 'Watched')}, :class_name => 'Invite', foreign_key: :inviteable_id

  has_many :scribbles, :as => :scribbled, :dependent => :destroy
  accepts_nested_attributes_for :scribbles
  
  scope :available, -> {where('start_date >= ?', Time.now)}
                      
  def places_left
    if self.max_students.nil? && self.min_students.nil?
    return "*"
    else
    return self.max_students -=self.min_students
    end
  end
  
  def build_image
     if self.skillimage.nil?
       self.build_skillimage()
     end
  end
end
