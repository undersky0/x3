class Album < ActiveRecord::Base
  attr_accessible :name, :description, :cover, :token
  has_many :pictures, :dependent => :destroy
  
  belongs_to :albumable, :polymorphic => true
  
  
    def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless Gallery.where(token: random_token).exists?
    end
  end
  
end
