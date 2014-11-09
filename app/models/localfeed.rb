class Localfeed < ActiveRecord::Base
  attr_accessible :city, :scribble_id, :location_id, :localfeed_id, :scribble_attributes, :localfeed_attributes
  
  has_many :scribbles, :as => :scribbled
  accepts_nested_attributes_for :scribbles
  before_validation :downcase_city
  validates :city, :presence => true, :uniqueness => { :case_sensitive => false }
  belongs_to :ward
  after_save :first_scribble
  
  private
  def downcase_city
    self.city = self.city.downcase if self.city.present?
  end
  
  def first_scribble
    self.scribbles.create!(:user_id => User.first.id, :post => "Welcome, You are the first in #{self.city} to join our network! ")
  end
end
