class User < ActiveRecord::Base
  
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  acts_as_messageable
  #acts_as_authorization_subject  :association_name => :roles
  include Scrubber
  searchkick
  make_flagger
  acts_as_voter
  after_save :create_avatar, :create_cover, :create_profile
  before_save :create_actor_id
  
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


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :user_id, :photo_attributes, :email, :password, :password_confirmation, :remember_me, :scribbles_attributes, :profile_attributes, :location_attributes, :useravatar_attributes, :usercover_attributes

  
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
  
  has_many :friendship
  
  has_many :friends, -> { where  "friendships.status = 'accepted'" }, :through => :friendship, source: :friend
  
  
  has_many :requested_friends, -> { where "friendships.status = 'requested'"},
           through: :friendship, source: :friend
           
  has_many :pending_friends, -> { where "friendships.status = 'pending'" },
           through: :friendship, source: :friend
     
  def create_actor_id
    begin
      self.actor_id = SecureRandom.base64(8)
    end while self.class.exists?(:actor_id => actor_id)
    end    
       
  def prefix
    try(:full_name) || email
  end

  
  def full_name
    @profile = self.profile
    if @profile.try(:firstname).nil?
      return "No Name"
    else
    return "#{@profile.firstname.humanize} #{@profile.lastname.humanize}"
    end
  end
  
  def name
    @profile = self.profile
    if @profile.try(:firstname).nil?
      return "No Name"
    else
    return "#{@profile.firstname.humanize} #{@profile.lastname.humanize}"
    end
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
    
#new facebook auth
      def self.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
    end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Authentication.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new
        user.build_profile
        user.build_useravatar
       # user.email = auth.extra.raw_info.email 
       #user.name = auth.info.nickname || auth.uid,
       user.profile.firstname = auth.extra.raw_info.first_name
       user.profile.lastname =  auth.extra.raw_info.last_name
       user.profile.age = auth.extra.raw_info.birthday
      
       user.email = "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
       pass = Devise.friendly_token[0,10]
       user.password = pass
       user.password_confirmation = pass
      if auth.info.image.present?
        # avatar_url = process_uri(auth.info.image)
        # user.useravatar.update_attribute(:attachement => URI.parse(avatar_url))
        avatar_url = process_uri(auth.info.image)
         user.useravatar.attachment = URI.parse(avatar_url)
      end 
       
       # avatar_url = process_uri(auth.info.image)
       # user.useravatar.attachment = URI.parse(avatar_url)
          
        
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end    
  
  
  
  end
  
  
