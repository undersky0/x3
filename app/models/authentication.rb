class Authentication < ActiveRecord::Base
  attr_accessible :provider, :token, :uid, :user_id, :token_secret
  belongs_to :user
  
  
  def facebook
  @facebook ||= Koala::Facebook::API.new(self.token)
  block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
  logger.info e.to_s
  nil # or consider a custom null object
end

def friends_count
  facebook { |fb| fb.get_connection("me", "friends").size }
end


def users_token
      au = Authentication.find_by_user_id(current_user.id)
      oauth_token = au.token
      return "oauth_token"
end

end
