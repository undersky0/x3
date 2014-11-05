class User < ActiveRecord::Base
 acts_as_messageable
  #acts_as_authorization_subject  :association_name => :roles
  include Scrubber
  searchkick
  make_flagger
  acts_as_voter
  before_save :create_actor_id, :create_location, :create_avatar, :create_cover, :create_profile
  
  
  has_many :scribbles, :as => :scribbled, :dependent => :destroy
  accepts_nested_attributes_for :scribbles
  has_many :invitations, :as => :invited  
  has_many :authentications
  has_many :invites
  accepts_nested_attributes_for :invites
  has_many :skills, dependent: :destroy
  accepts_nested_attributes_for :skills

  has_one :useravatar, :as => :assetable, :class_name => "Group::Useravatar", :dependent => :destroy
  accepts_nested_attributes_for :useravatar, reject_if: :all_blank
  
  has_one :usercover, :as => :assetable, :class_name => "Group::Usercover", :dependent => :destroy
  accepts_nested_attributes_for :usercover, reject_if: :all_blank
  
  has_many :albums, :as => :albumable, :dependent => :destroy
  accepts_nested_attributes_for :albums

  #set_primary_key :id
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :user_id, :photo_attributes, :email, :password, :password_confirmation, :remember_me, :scribbles_attributes, :profile_attributes, :location_attributes, :useravatar_attributes, :usercover_attributes
  # attr_accessible :title, :body
  
  has_one :avatar, :as => :avatarable, :dependent => :destroy
  accepts_nested_attributes_for :avatar
  
  has_one :profile,
          dependent: :destroy
          accepts_nested_attributes_for :profile
  
  has_one :location, :as => :mappable,
  dependent: :destroy
  accepts_nested_attributes_for :location
  
  has_many :scribbles
  
  
  
  has_many :comments
  
  has_many :memberships, dependent: :destroy
  has_many :groups, :through => :memberships
  
  has_many :groups
  
  #user.places , location.places, user.locations
  # has_many :locations, :through => :places, :primary_key => 'user_id'
  # has_many :places, :as => :locationable, :primary_key => 'user_id'
#   
  

  # accepts_nested_attributes_for :locations
  
  # @user = User.find(params[:id]) # finds user
  # @commentable = @user # find the right link with commentable
  # @comments = @commentable.comments # finds the associated comments
  # @comment = Comment.new 
  #after_create :create_avatar
  #self.primary_key = 'actor_id'
  
  
  has_many :friendship
  
  has_many :friends, -> { where  "friendships.status = 'accepted'" }, :through => :friendship, source: :friend
  
  
  has_many :requested_friends, -> { where ("friendships.status = 'requested'")},
           through: :friendship, source: :friend
           
  has_many :pending_friends, -> { where("friendships.status = 'pending'")},
           through: :friendship, source: :friend
           
  # has_many :neighbours,
           # :through => :friendships,
           # :source => :friend,
           # :conditions => :location
           
    
    #after_initialize :create_profile
    # before_create :create_location
    # before_create :create_avatar
    # before_create :create_profile
           
  # def unread_messages?
    # unread_messages_count > 0 ? true : false
  # end
     
           
  def create_actor_id
    begin
      self.actor_id = SecureRandom.base64(8)
    end while self.class.exists?(:actor_id => actor_id)
    end    
       
  def prefix
    try(:full_name) || email
  end
# def message_title
    # "#{prefix} <#{email}>"
# end
# 
# def mailbox
  # mailbox.new(self)
# end
  
  def full_name
    @profile = self.profile
    return "#{@profile.firstname.humanize} #{@profile.lastname.humanize}"
  end
  
  def name
    @profile = self.profile
    return "#{@profile.firstname.humanize} #{@profile.lastname.humanize}"
  end
  
  def create_profile
    self.build_profile() if self.profile.nil?
  end      
  def create_location
    self.build_location() if self.location.nil?
  end
  def create_avatar
    self.build_useravatar() if self.useravatar.nil?
  end
    def create_cover
    self.build_usercover() if self.usercover.nil?
  end
  
  def joined?(group)
    self.memberships.find_by_group_id(group)
  end    
  
  def oauth_token
    
  end
  
    def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'], 
                          :uid => omni['uid'], 
                          :token => omni['credentials'].token, 
                          :token_secret => omni['credentials'].secret)
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super #&& provider.blank?
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

def facebook
  @facebook ||= Koala::Facebook::API.new(oauth_token)
  block_given? ? yield(@facebook) : @facebook
rescue Koala::Facebook::APIError => e
  logger.info e.to_s
  nil # or consider a custom null object
end

def friends_count
  facebook { |fb| fb.get_connection("me", "friends").size }
end

def mailboxer_email(user)
  if !user.nil?
    return self.email
  else
    return nil
  end
end

#soulemate
    def self.search(name)
    profiles = Soulmate::Matcher.new("profile").matches_for_term(name)
    profiles.collect { |c| { "id" => c["id"], "firstname" => c["term"], "firstname" => c["firstname"], "lastname" => c["lastname"] } }
    end
    
    
    def avatar_remote_url=(url_value)
      self.avatar.photo = URI.parse(url_value)
      @avatar_remote_url = url_value
    end

  end
  
  
